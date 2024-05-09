using System.Text.Json;
using System.Text.Json.Serialization;

using backend.Models;

using FluentValidation;
using FluentValidation.Results;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;

using OfficeOpenXml;

namespace backend.Controllers;

[ApiController]
[Route("/purchase-orders")]
public class PurchaseOrderController : ControllerBase
{
    private readonly DatabaseContext _context;

    private readonly DbSet<PurchaseOrder> _dbSet;

    public PurchaseOrderController(DatabaseContext context)
    {
        this._context = context;
        this._dbSet = context.Set<PurchaseOrder>();

    }

    [HttpGet(Name = "GetPurchaseOrders/{query?}/{state?}/{limit?}/{offset?}")]
    public ActionResult<Dictionary<string, List<PurchaseOrder>>> Get(
            String? query, PurchaseOrderState? state, int? limit, int? offset
        )
    {
        query = query?.ToLower();
        IQueryable<PurchaseOrder> dbQuery = this._dbSet;
        if (!String.IsNullOrEmpty(query))
        {
            dbQuery = dbQuery.Where(x =>
                x.Name.ToLower().Contains(query) ||
                x.Supplier.ToLower().Contains(query) ||
                x.PoIdentification.ToLower().Equals(query));
        }
        if (state != null)
        {
            dbQuery = dbQuery.Where(x => x.State.Equals(state));
        }

        foreach (var po in dbQuery.ToList())
        {
            _context.Entry(po).Collection(po => po.ASNs).Load();
            foreach (var asn in po.ASNs)
            {
                _context.Entry(asn).Collection(asn => asn.ProductList).Load();
            }
        }

        var totalResults = dbQuery.Count();

        if (offset != null)
        {
            dbQuery = dbQuery.Skip(offset.Value);
        }
        if (limit is not null)
        {
            dbQuery = dbQuery.Take(limit.Value);
        }

        return Ok(new Dictionary<string, object>
        {
            ["purchaseOrders"] = dbQuery.ToList(),
            ["totalResults"] = totalResults
        });
    }

    [HttpGet("{purchaseOrderNumber}", Name = "GetPurchaseOrder")]
    public ActionResult<PurchaseOrder> GetPurchaseOrder(int purchaseOrderNumber)
    {
        var purchaseOrder = _dbSet.SingleOrDefault(po => po.Id == purchaseOrderNumber);

        if (purchaseOrder == null)
        {
            throw new KeyNotFoundException("No Purchase order found with ID " + purchaseOrderNumber);
        }


        _context.Entry(purchaseOrder).Collection(po => po.ASNs).Load();

        foreach (var asn in purchaseOrder.ASNs)
        {
            _context.Entry(asn).Collection(asn => asn.ProductList).Load();
        }

        return Ok(purchaseOrder);
    }

    [HttpPost("new", Name = "CreatePurchaseOrder")]
    public IActionResult Create(PurchaseOrderDTO dto,
        [FromServices] IValidator<PurchaseOrder> validator)
    {
        PurchaseOrder po = new(dto);
        ValidationResult validationResult = validator.Validate(po);
        if (!validationResult.IsValid)
        {
            var modelStateDict = new ModelStateDictionary();
            foreach (ValidationFailure fail in validationResult.Errors)
            {
                modelStateDict.AddModelError(fail.PropertyName, fail.ErrorMessage);
            }

            return ValidationProblem(modelStateDict);
        }

        var entity = _dbSet.Add(po).Entity;
        _context.SaveChanges();
        return CreatedAtRoute("CreatePurchaseOrder", entity);
    }

    [HttpPut("{purchaseOrderNumber}", Name = "EditPurchaseOrder")]
    public IActionResult Edit(PurchaseOrderDTO dto)
    {
        var purchaseOrder = _dbSet.SingleOrDefault(po => po.PoIdentification == dto.PoIdentification);

        if (purchaseOrder == null)
        {
            throw new KeyNotFoundException("No Purchase order found with ID " + dto.PoIdentification);
        }

        purchaseOrder.Name = dto.Name;
        purchaseOrder.Supplier = dto.Supplier;
        purchaseOrder.TotalItems = dto.TotalItems;
        _context.SaveChanges();

        return Ok(purchaseOrder);
    }

    [HttpGet("{purchaseOrderNumber}/asn", Name = "GetASNsByPurchaseOrder")]
    public ActionResult<List<ASN>> GetByPurchaseOrder(int purchaseOrderNumber)
    {
        var purchaseOrder = _dbSet.SingleOrDefault(po => po.Id == purchaseOrderNumber);

        if (purchaseOrder == null)
        {
            throw new KeyNotFoundException("No Purchase order found with ID " + purchaseOrderNumber);
        }

        _context.Entry(purchaseOrder).Collection(po => po.ASNs).Load();

        return Ok(new Dictionary<string, List<ASN>>
        {
            ["asn"] = purchaseOrder?.ASNs.ToList() ?? new List<ASN>()
        });
    }

    [HttpPut("{purchaseOrderNumber}/cancel", Name = "CancelPurchaseOrder")]
    public IActionResult CancelPurchaseOrder(int purchaseOrderNumber)
    {
        var purchaseOrder = _dbSet.Find(purchaseOrderNumber);

        if (purchaseOrder == null)
        {
            throw new KeyNotFoundException("No Purchase order found with ID " + purchaseOrderNumber);
        }
        if (purchaseOrder.State == PurchaseOrderState.Archived)
        {
            throw new InvalidOperationException("Purchase order can't be cancelled because it's archived");
        }

        purchaseOrder.State = PurchaseOrderState.Cancelled;
        _context.SaveChanges();

        return Ok(purchaseOrder);
    }

    [HttpPut("{purchaseOrderNumber}/archive", Name = "ArchivePurchaseOrder")]
    public IActionResult ArchivePurchaseOrder(int purchaseOrderNumber)
    {
        var purchaseOrder = _dbSet.Find(purchaseOrderNumber);

        if (purchaseOrder == null)
        {
            throw new KeyNotFoundException("No Purchase order found with ID " + purchaseOrderNumber);
        }
        if (purchaseOrder.State == PurchaseOrderState.Cancelled)
        {
            throw new InvalidOperationException("Purchase order can't be archived because it's cancelled");
        }

        purchaseOrder.State = PurchaseOrderState.Archived;
        _context.SaveChanges();

        return Ok(purchaseOrder);
    }

    [HttpGet("{id}/export", Name = "GetPurchaseOrderFile")]
    public ActionResult<PurchaseOrder> GetFile(int id)
    {
        PurchaseOrder? po = _dbSet.Find(id);

        if (po == null)
        {
            return NotFound("No Purchase order found with the given ID.");
        }

        _context.Entry(po).Collection(po => po.ASNs).Load();
        foreach (var asn in po.ASNs)
        {
            _context.Entry(asn).Collection(asn => asn.ProductList).Load();
        }

        ExcelPackage package = new ExcelPackage();
        ExcelWorksheet sheet = package.Workbook.Worksheets.Add("Purchase Order");
        sheet.Cells[1, 1].Value = "PoIdentification";
        sheet.Cells[2, 1].Value = po.PoIdentification;
        sheet.Cells[1, 2].Value = "State";
        sheet.Cells[2, 2].Value = po.State;
        sheet.Cells[1, 3].Value = "Name";
        sheet.Cells[2, 3].Value = po.Name;
        sheet.Cells[1, 4].Value = "Supplier";
        sheet.Cells[2, 4].Value = po.Supplier;
        sheet.Cells[1, 5].Value = "ReceivedItems";
        sheet.Cells[2, 5].Value = po.ReceivedItems;
        sheet.Cells[1, 6].Value = "TotalItems";
        sheet.Cells[2, 6].Value = po.TotalItems;
        sheet.Cells[3, 1].Value = "ASNs";

        sheet.Cells[4, 1].Value = "Id";
        sheet.Cells[4, 2].Value = "State";
        sheet.Cells[4, 3].Value = "Shipment reference";
        sheet.Cells[4, 4].Value = "Shipping from address";
        sheet.Cells[4, 5].Value = "Shipping to Warehouse";
        sheet.Cells[4, 6].Value = "Expected delivery date";
        sheet.Cells[4, 7].Value = "Carrier name";
        sheet.Cells[4, 8].Value = "Cargo type";
        sheet.Cells[4, 9].Value = "Shipper contact";
        sheet.Cells[4, 10].Value = "Purchase order number";
        sheet.Cells[4, 11].Value = "Purchase order date";
        sheet.Cells[4, 12].Value = "Product code";
        sheet.Cells[4, 13].Value = "Quantity";

        int rowIndex = 5;

        foreach (ASN asn in po.ASNs)
        {
            foreach (Product product in asn.ProductList)
            {
                sheet.Cells[rowIndex, 1].Value = asn.Id;
                sheet.Cells[rowIndex, 2].Value = asn.State.ToString();
                sheet.Cells[rowIndex, 3].Value = asn.ShipmentReference?.ToString();
                sheet.Cells[rowIndex, 4].Value = asn.Address;
                sheet.Cells[rowIndex, 5].Value = asn.Warehouse;
                sheet.Cells[rowIndex, 6].Value = asn.ExpectedDeliveryDate?.ToString("yyyy-MM-ddTHH:mm:ssZ", System.Globalization.CultureInfo.InvariantCulture);
                sheet.Cells[rowIndex, 7].Value = asn.CarrierName;
                sheet.Cells[rowIndex, 8].Value = asn.Type;
                sheet.Cells[rowIndex, 9].Value = asn.ShipperContact;
                sheet.Cells[rowIndex, 10].Value = asn.PurchaseOrder?.PoIdentification;
                sheet.Cells[rowIndex, 11].Value = asn.PurchaseOrderDate?.ToString("yyyy-MM-ddTHH:mm:ssZ", System.Globalization.CultureInfo.InvariantCulture);
                sheet.Cells[rowIndex, 12].Value = product.Name;
                sheet.Cells[rowIndex, 13].Value = product.Quantity;
                rowIndex++;
            }
        }

        var cd = new System.Net.Mime.ContentDisposition
        {
            FileName = "purchase_order_" + po.PoIdentification + ".xlsx",
            Inline = false,
        };
        Response.Headers["Content-Disposition"] = cd.ToString();

        return File(package.GetAsByteArray(), "application/octet-stream");
    }
}