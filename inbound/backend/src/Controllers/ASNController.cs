using backend.Models;

using FluentValidation;
using FluentValidation.Results;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;

using OfficeOpenXml;

namespace backend.Controllers;

[ApiController]
[Route("/asn")]
public class ASNController : ControllerBase
{
    private readonly DatabaseContext _context;

    private readonly DbSet<ASN> _dbSet;
    private readonly DbSet<PurchaseOrder> _dbSetPO;

    public ASNController(DatabaseContext context)
    {
        this._context = context;
        this._dbSet = context.Set<ASN>();
        this._dbSetPO = context.Set<PurchaseOrder>();
    }

    [HttpGet(Name = "GetASNs/{query?}/{state?}/{limit?}/{offset?}")]
    public ActionResult<Dictionary<string, List<ASN>>> Get(
            String? query, ASNState? state, int? limit, int? offset
        )
    {

        foreach (var asn in _dbSet.ToList())
        {
            _context.Entry(asn).Collection(asn => asn.ProductList).Load();
        }

        query = query?.ToLower();
        IQueryable<ASN> dbQuery = this._dbSet;
        if (!String.IsNullOrEmpty(query))
        {
            dbQuery = dbQuery.Where(x =>
                x.ShipmentReference.ToLower().Contains(query) ||
                x.CarrierName.ToLower().Contains(query) ||
                x.Warehouse.ToLower().Contains(query));
        }
        if (state != null)
        {
            dbQuery = dbQuery.Where(x => x.State.Equals(state));
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
            ["asn"] = dbQuery.Include(asn => asn.ProductList).ToList(),
            ["totalResults"] = totalResults
        });
    }

    [HttpPost(Name = "CreateASN")]
    public IActionResult Create(ASNCreateDTO dto, [FromServices] IValidator<ASN> validator)
    {
        ASN asn = new ASN(dto);

        ValidationResult validationResult = validator.Validate(asn);
        if (!validationResult.IsValid)
        {
            var modelStateDict = new ModelStateDictionary();
            foreach (ValidationFailure fail in validationResult.Errors)
            {
                modelStateDict.AddModelError(fail.PropertyName, fail.ErrorMessage);
            }

            return ValidationProblem(modelStateDict);
        }


        if (asn.PurchaseOrderId != null)
        {
            var purchaseOrder = _dbSetPO.SingleOrDefault(po => po.Id == asn.PurchaseOrderId);

            if (purchaseOrder != null)
            {
                _context.Entry(purchaseOrder).Collection(po => po.ASNs).Load();

                purchaseOrder.ASNs.Add(asn);
                _context.Entry(purchaseOrder).State = EntityState.Modified;
            }
        }

        var newAsn = _dbSet.Add(asn).Entity;
        _context.SaveChanges();
        return CreatedAtRoute("CreateASN", newAsn);
    }

    [HttpPut("{id}", Name = "EditASN")]
    public IActionResult Edit(ASNEditDTO dto)
    {
        var asn = _dbSet.SingleOrDefault(asn => asn.ShipmentReference == dto.ShipmentReference);

        if (asn == null)
        {
            throw new KeyNotFoundException("No ASN found with ID " + asn.ShipmentReference);
        }

        asn.Warehouse = dto.Warehouse;
        asn.ShipperContact = dto.ShipperContact;
        asn.Address = dto.Address;
        asn.CarrierName = dto.CarrierName;
        _context.SaveChanges();

        return Ok(asn);
    }

    [HttpPost("import", Name = "CreateASNFromFile")]
    public ActionResult<ASN> CreateFromFile(IFormFile asnFile, int? poID)
    {


        long size = asnFile.Length;

        PurchaseOrder? purchaseOrder = null;

        if (poID != null)
        {
            purchaseOrder = _dbSetPO.SingleOrDefault(po => po.Id == poID);

            if (purchaseOrder == null)
            {
                throw new KeyNotFoundException("No Purchase Order found with ID " + poID == null ? "null" : "not null");
            }
        }

        ASN asn = new ASN();

        if (asnFile.Length == 0)
        {
            throw new InvalidDataException("Empty ASN Excel file.");
        }

        using (var stream = asnFile.OpenReadStream())
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (ExcelPackage package = new ExcelPackage(stream))
            {
                ExcelWorksheet sheet = package.Workbook.Worksheets[0];
                int colCount = sheet.Dimension.End.Column; //get Column Count
                int rowCount = sheet.Dimension.End.Row; //get row count
                if (colCount < 11)
                {
                    throw new InvalidDataException(
                        "Invalid ASN Excel file. Not enough columns. Be sure to follow the template.");
                }

                if (rowCount < 2)
                {
                    throw new InvalidDataException(
                        "Invalid ASN Excel file. No records found. Be sure to follow the template.");
                }

                // Shipment Reference (string, required)
                asn.ShipmentReference = sheet.Cells[2, 1].Value?.ToString();
                if (string.IsNullOrEmpty(asn.ShipmentReference))
                {
                    throw new InvalidDataException("Invalid ASN Excel file. Missing shipment reference.");
                }

                // Shipping Address (string, optional)
                asn.Address = sheet.Cells[2, 2].Value?.ToString();

                // Shipment Warehouse (string, required)
                asn.Warehouse = sheet.Cells[2, 3].Value?.ToString();
                if (string.IsNullOrEmpty(asn.ShipmentReference))
                {
                    throw new InvalidDataException("Invalid ASN Excel file. Missing receiving warehouse.");
                }

                // Expected Delivery Date (date, required)
                string? date = sheet.Cells[2, 4].Value?.ToString();
                if (date == null)
                {
                    throw new InvalidDataException("Invalid ASN Excel file. Missing expected delivery date.");
                }
                long dateNum;
                if (!long.TryParse(date, out dateNum))
                {
                    throw new InvalidDataException("Invalid ASN Excel file. Invalid delivery date.");
                }
                asn.ExpectedDeliveryDate = DateTime.FromOADate(dateNum);
                if (asn.ExpectedDeliveryDate == null)
                {
                    throw new InvalidDataException("Invalid ASN Excel file. Missing expected delivery date.");
                }

                // Carrier Name (string, optional)
                asn.CarrierName = sheet.Cells[2, 5].Value?.ToString();

                // Cargo Type (string, optional)
                string? cargoType = sheet.Cells[2, 6].Value?.ToString();

                if (!string.IsNullOrEmpty(cargoType) && cargoType.ToLower() != "normal" &&
                    cargoType.ToLower() != "dangerous")
                {
                    throw new InvalidDataException("Invalid ASN Excel file. Missing expected delivery date.");
                }

                if (cargoType?.ToLower() == "normal")
                    asn.Type = CargoType.Normal;
                else if (cargoType?.ToLower() == "dangerous")
                    asn.Type = CargoType.Dangerous;

                // Shipper Contact (string, optional)
                asn.ShipperContact = sheet.Cells[2, 7].Value?.ToString();



                // PO Number (string, optional)
                string? poIdentification = sheet.Cells[2, 8].Value?.ToString();

                if (poIdentification != null)
                {
                    if (poID == null)
                    {
                        purchaseOrder = _dbSetPO.SingleOrDefault(po => po.PoIdentification == poIdentification);
                    }
                    if (purchaseOrder != null)
                    {
                        if (poIdentification != purchaseOrder.PoIdentification)
                        {
                            throw new InvalidDataException(
                                "Invalid ASN Excel file. Purchase order number must match the current purchase order.");
                        }
                        asn.PurchaseOrderId = purchaseOrder.Id;
                    }
                    else
                    {
                        throw new InvalidDataException(
                            "Invalid Purchase order number. A purchase order with the given purchase order number doesn't exist.");
                    }

                }

                // PO Date (date, optional)
                date = sheet.Cells[2, 9].Value?.ToString();
                if (date == null) asn.PurchaseOrderDate = null;
                else
                {
                    if (!long.TryParse(date, out dateNum))
                    {
                        throw new InvalidDataException("Invalid ASN Excel file. Invalid purchase order date.");
                    }
                    asn.PurchaseOrderDate = DateTime.FromOADate(dateNum);
                }

                List<Product> productList = new List<Product>();

                for (int row = 2; row <= rowCount; row++)
                {
                    bool skipRow = true;
                    for (int col = 1; col <= 11; col++)
                    {
                        if (sheet.Cells[row, col].Value != null) skipRow = false;
                    }
                    if (skipRow) continue;
                    for (int col = 1; col <= 9; col++)
                    {
                        if (sheet.Cells[row, col].Value?.ToString() != sheet.Cells[2, col].Value?.ToString())
                        {
                            throw new InvalidDataException(
                                "Invalid ASN Excel file. ASN information must be the same for all lines.");
                        }
                    }
                    Product product = new Product();
                    product.Name = sheet.Cells[row, 10].Value?.ToString();
                    if (string.IsNullOrEmpty(product.Name))
                    {
                        throw new InvalidDataException("Invalid ASN Excel file. The product code is required.");
                    }

                    if (sheet.Cells[row, 11].Value.GetType() != typeof(double))
                    {
                        throw new InvalidDataException("Invalid ASN Excel file. The product quantity is required.");
                    }
                    product.Quantity = Convert.ToInt32(sheet.Cells[row, 11].Value);
                    productList.Add(product);
                }

                asn.ProductList = productList;
            }
        }

        var newAsn = _dbSet.Add(asn).Entity;
        _context.SaveChanges();

        return CreatedAtRoute("CreateASNFromFile", newAsn);
    }

    [HttpGet("{id}", Name = "GetASN")]
    public ActionResult<ASN> Get(int id)
    {
        var asn = _dbSet.Find(id);

        if (asn == null)
        {
            throw new KeyNotFoundException("No ASN found with ID " + id);
        }

        _context.Entry(asn).Collection(asn => asn.ProductList).Load();

        return Ok(asn);
    }

    [HttpGet("{id}/export", Name = "GetASNFile")]
    public ActionResult<ASN> GetFile(int id)
    {
        ASN? asn = _dbSet.Find(id);

        if (asn == null)
        {
            return NotFound("No ASN found with the given ID.");
        }

        _context.Entry(asn).Collection(asn => asn.ProductList).Load();

        ExcelPackage package = new ExcelPackage();
        ExcelWorksheet sheet = package.Workbook.Worksheets.Add("ASN");

        sheet.Cells[1, 1].Value = "Shipment reference";
        sheet.Cells[1, 2].Value = "Shipping from address";
        sheet.Cells[1, 3].Value = "Shipping to Warehouse";
        sheet.Cells[1, 4].Value = "Expected delivery date";
        sheet.Cells[1, 5].Value = "Carrier name";
        sheet.Cells[1, 6].Value = "Cargo type";
        sheet.Cells[1, 7].Value = "Shipper contact";
        sheet.Cells[1, 8].Value = "Purchase order number";
        sheet.Cells[1, 9].Value = "Purchase order date";
        sheet.Cells[1, 10].Value = "Product code";
        sheet.Cells[1, 11].Value = "Quantity";

        int rowIndex = 2;

        foreach (Product product in asn.ProductList)
        {
            sheet.Cells[rowIndex, 1].Value = asn.ShipmentReference?.ToString();
            sheet.Cells[rowIndex, 2].Value = asn.Address;
            sheet.Cells[rowIndex, 3].Value = asn.Warehouse;
            sheet.Cells[rowIndex, 4].Value = asn.ExpectedDeliveryDate?.ToString("yyyy-MM-ddTHH:mm:ssZ", System.Globalization.CultureInfo.InvariantCulture);
            sheet.Cells[rowIndex, 5].Value = asn.CarrierName;
            sheet.Cells[rowIndex, 6].Value = asn.Type;
            sheet.Cells[rowIndex, 7].Value = asn.ShipperContact;
            sheet.Cells[rowIndex, 8].Value = asn.PurchaseOrder?.PoIdentification;
            sheet.Cells[rowIndex, 9].Value = asn.PurchaseOrderDate?.ToString("yyyy-MM-ddTHH:mm:ssZ", System.Globalization.CultureInfo.InvariantCulture);
            sheet.Cells[rowIndex, 10].Value = product.Name;
            sheet.Cells[rowIndex, 11].Value = product.Quantity;
            rowIndex++;
        }

        var cd = new System.Net.Mime.ContentDisposition
        {
            FileName = "asn.xlsx",
            Inline = false,
        };
        Response.Headers["Content-Disposition"] = cd.ToString();

        return File(package.GetAsByteArray(), "application/octet-stream");
    }

    [HttpPut("{id}/cancel", Name = "CancelASN")]
    public IActionResult CancelASN(int id)
    {
        var asn = _dbSet.Find(id);

        if (asn == null)
        {
            throw new KeyNotFoundException("No ASN found with ID " + id);
        }

        asn.State = ASNState.Cancelled;
        _context.SaveChanges();

        return Ok(asn);
    }

    [HttpPut("{id}/book", Name = "BookASN")]
    public IActionResult BookASN(int id)
    {
        var asn = _dbSet.Find(id);

        if (asn == null)
        {
            throw new KeyNotFoundException("No ASN found with that ID");
        }

        asn.State = ASNState.Booked;
        _context.SaveChanges();

        return Ok(asn);
    }

    [HttpPut("{id}/receive", Name = "ReceiveASN")]
    public IActionResult ReceiveASN(int id)
    {
        var asn = _dbSet.Find(id);

        if (asn == null)
        {
            throw new KeyNotFoundException("No ASN found with that ID");
        }

        asn.State = ASNState.Received;
        _context.SaveChanges();

        return Ok(asn);
    }

    [HttpGet("template", Name = "TemplateASN")]
    public IActionResult TemplateASN()
    {
        string filePath = "Resources/ASN_Template_File.xlsx";

        if (!System.IO.File.Exists(filePath))
        {
            return NotFound(new { error = "No template file found" });
        }

        var fileBytes = System.IO.File.ReadAllBytes(filePath);

        return File(fileBytes, "application/vnd.ms-excel", Path.GetFileName(filePath));
    }
}