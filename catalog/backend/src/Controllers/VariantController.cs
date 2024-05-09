using System.Net;

using backend.Common;
using backend.Controllers.Auxiliar;
using backend.Models;

using FluentValidation;

using Microsoft.AspNetCore.Mvc;

using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Schema;

using OfficeOpenXml;

namespace backend.Controllers;

[ApiController]
[Route("/variants")]
public class VariantController : ControllerBase
{
    private readonly DatabaseContext _context;
    private const int DEFAULT_PAGE_SIZE = 10;
    private const int DEFAULT_PAGE_NUMBER = 1;

    public VariantController(DatabaseContext context)
    {
        this._context = context;
    }

    private IQueryable<Variant> FilterVariants(string? filter)
    {
        if (String.IsNullOrEmpty(filter))
        {
            return _context.Set<Variant>();
        }

        filter = filter.ToLower();

        IQueryable<Variant> variants = _context.Set<Variant>();
        variants = variants.Where(v =>
            v.VariantDescription.ToLower().Contains(filter) ||
            v.Composition.ToLower().Contains(filter) ||
            v.Product.Name.ToLower().Contains(filter) ||
            v.Product.Brand.Name.ToLower().Contains(filter)
        );

        return variants;
    }

    [HttpGet(Name = "GetVariants")]
    public IActionResult Get([FromQuery] int? pageNumber, [FromQuery] int? pageSize, [FromQuery] string? q, [FromQuery] int? brandId)
    {
        if (pageNumber != null && pageNumber < 1)
        {
            return BadRequest(new { variants = new List<Variant>(), error = "Page number must be greater than 0" });
        }

        if (pageSize != null && pageSize < 1)
        {
            return BadRequest(new { variants = new List<Variant>(), error = "Page size must be greater than 0" });
        }

        var variants = FilterVariants(q);
        if (brandId != null)
        {
            variants = variants.Where(v => v.Product.BrandId == brandId);
        }

        return Ok(new { variants = PaginatedList<Variant>.CreateAsync(variants.Where(v => !v.IsArchived).OrderBy(v => v.Product.Name), pageNumber ?? DEFAULT_PAGE_NUMBER, pageSize ?? DEFAULT_PAGE_SIZE).Result });
    }

    [HttpGet("pages", Name = "GetVariantsNumberOfPages")]
    public async Task<IActionResult> GetPages([FromQuery] int? pageSize, [FromQuery] string? q, [FromQuery] int? brandId)
    {
        if (pageSize != null && pageSize < 1)
        {
            return BadRequest(new { pages = 0, error = "Page size must be greater than 0" });
        }

        var variants = FilterVariants(q);

        if (brandId != null)
        {
            variants = variants.Where(v => v.Product.BrandId == brandId);
        }

        var variantsList = await PaginatedList<Variant>.CreateAsync(variants.Where(v => !v.IsArchived), DEFAULT_PAGE_NUMBER, pageSize ?? DEFAULT_PAGE_SIZE);

        return Ok(new { pages = variantsList.TotalPages });
    }

    [HttpGet("{id}", Name = "GetVariant")]
    public IActionResult Get(int id)
    {
        var variant = _context.Variants?.Find(id);

        if (variant == null)
        {
            return NotFound(new { variant = new { }, error = "No Variant found with Id " + id });
        }

        return Ok(new { variant = variant });
    }

    [HttpPost("add", Name = "CreateVariant")]
    public async Task<IActionResult> Post([FromBody] VariantDTO variantDTO, [FromServices] IValidator<Variant> validator)
    {
        var variant = new Variant(variantDTO);

        var variantValidation = RoutesUtils.Validate(validator, variant);
        if (variantValidation != null) return ValidationProblem(variantValidation);

        // if no product for given ProductId, return NotFound
        if (_context.Products?.Find(variant.ProductId) == null)
        {
            return BadRequest(new { error = "No Product found with Id " + variant.ProductId });
        }

        _context.Variants?.Add(variant);
        await _context.SaveChangesAsync();

        return CreatedAtRoute("GetVariant", new { id = variant.Id }, variant);
    }

    [HttpPut("{variantId}", Name = "EditVariant")]
    [Consumes("application/json")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public IActionResult EditVariant(int variantId, [FromBody] VariantDTO variantDto, [FromServices] IValidator<Variant> validator)
    {
        var variant = _context.Variants?.Find(variantId);
        if (variant == null)
        {
            return NotFound(new { variant = new { }, error = "No Variant found with Id " + variantId });
        }

        var newVariant = Variant.VariantWithId(variantId, variantDto);

        var variantValidation = RoutesUtils.Validate(validator, newVariant);
        if (variantValidation != null) return ValidationProblem(variantValidation);

        // if no product for given ProductId, return NotFound
        if (_context.Products?.Find(newVariant.ProductId) == null)
        {
            return BadRequest(new { error = "No Product found with Id " + newVariant.ProductId });
        }

        _context.Entry(variant).CurrentValues.SetValues(newVariant);
        _context.SaveChanges();

        return Ok(new { id = variant.Id, productId = variant.ProductId });
    }

    [HttpPost("archive/{id}", Name = "ArchiveVariant")]
    public async Task<IActionResult> Post(int id, [FromBody] IsArchivedDTO isArchived)
    {
        var variant = _context.Variants?.Where(variant => variant.Id == id).FirstOrDefault();

        if (variant == null)
        {
            return NotFound(new { variant = new { }, error = "No Variant found with Id " + id });
        }

        variant.IsArchived = isArchived.IsArchived;

        await _context.SaveChangesAsync();

        return Ok();
    }

    [HttpGet("template", Name = "VariantsTemplate")]
    public async Task<ActionResult> DownloadFile()
    {
        const string filePath = "Resources/import_products_template.xls";
        if (!System.IO.File.Exists(filePath))
        {
            return NotFound(new { error = "No template file found" });
        }

        var bytes = await System.IO.File.ReadAllBytesAsync(filePath);
        return File(bytes, "application/vnd.ms-excel", Path.GetFileName(filePath));
    }


    [HttpPost("import", Name = "ImportVariants")]
    [Consumes("multipart/form-data")]
    public IActionResult ImportProducts(int brandId, [FromForm] IFormFile file,
        [FromServices] IValidator<Variant> vValidator,
        [FromServices] IValidator<Product> pValidator)
    {
        List<JObject> variants = new List<JObject>();
        try
        {
            variants = ImportUtils.ProcessExcel(file);
        }
        catch (Exception e)
        {
            return BadRequest(new { error = e.Message });
        }

        Brand? brand = _context.Brands?.Find(brandId);
        if (brand == null)
        {
            return BadRequest(new { error = "Brand does not exist" });
        }

        foreach (var variantObject in variants)
        {
            var productDTO = ImportUtils.BuildProductDTO(variantObject);
            var product = ImportUtils.FindProduct(productDTO, _context);
            if (product == null)
            {
                product = new Product(productDTO, brand.Id);
                var productValidation = RoutesUtils.Validate(pValidator, product);
                if (productValidation != null) return ValidationProblem(productValidation);
                _context.Products?.Add(product);
                _context.SaveChanges();
            }

            var variantDTO = ImportUtils.BuildVariantDTO(variantObject, product.Id);
            var variant = new Variant(variantDTO);
            var variantValidation = RoutesUtils.Validate(vValidator, variant);
            if (variantValidation != null) return ValidationProblem(variantValidation);
            _context.Variants?.Add(variant);
            _context.SaveChanges();
        }
        return Ok(new { filename = file.FileName, variants_added = variants.Count });
    }
}

public static class ImportUtils
{
    private static JObject RowToJson(List<string?> cells)
    {
        var json = new JObject();
        for (int i = 0; i < cells.Count; i++)
        {
            var elem = cells.ElementAt(i);
            json.Add(Constants.properties[i], elem);
        }

        return json;
    }

    public static List<JObject> ProcessExcel(IFormFile file)
    {
        const string productSchemaPath = "Resources/schema.json";
        const int expectedColumns = 30;

        var stream = file.OpenReadStream();

        //using OfficeOpenXml;
        ExcelPackage.LicenseContext = LicenseContext.Commercial;
        ExcelPackage xlPackage = new(stream);
        var myWorksheet = xlPackage.Workbook.Worksheets.First(); //select sheet one
        var totalColumns = myWorksheet.Dimension.End.Column;

        if (totalColumns != expectedColumns)
            throw new Exception($"Invalid file format. File should have {expectedColumns} columns");

        var variants = new List<JObject>();
        var rowNum = 2; // skip header row
        while (true)
        {
            var row = myWorksheet.Cells[rowNum, 1, rowNum, totalColumns]
                .Select(c => c.Value?.ToString()).ToList();
            if (row.All(string.IsNullOrEmpty)) break;
            var rowJson = RowToJson(row);

            JSchema schema = JSchema.Parse(File.ReadAllText(productSchemaPath));
            IList<string> messages;
            if (!rowJson.IsValid(schema, out messages))
                throw new Exception($"Invalid file format. Row {rowNum}: {messages.First()}");
            variants.Add(rowJson);
            rowNum++;
        }
        return variants;
    }

    public static Product? FindProduct(ProductDTO productDTO, DatabaseContext context)
    {
        return context.Products?.Where(product =>
            product.Name == productDTO.Name &&
            product.Description == productDTO.Description &&
            product.Season == productDTO.Season &&
            product.Supplier == productDTO.Supplier &&
            product.Type == productDTO.Type &&
            product.Family == productDTO.Family &&
            product.SubFamily == productDTO.SubFamily).FirstOrDefault();
    }

    public static ProductDTO BuildProductDTO(JObject variant)
    {
        return new ProductDTO
        {
            Name = getJObjectValueString(variant, "product name") ?? "",
            Description = getJObjectValueString(variant, "product description"),
            Season = getJObjectValueString(variant, "season"),
            Supplier = getJObjectValueString(variant, "supplier"),
            Type = getJObjectValueString(variant, "type"),
            Family = getJObjectValueString(variant, "family"),
            SubFamily = getJObjectValueString(variant, "subFamily"),
        };
    }
    public static VariantDTO BuildVariantDTO(JObject variant, int productId)
    {
        return new VariantDTO
        {
            ProductId = productId,
            SKU = getJObjectValueString(variant, "sku"),
            Barcode = getJObjectValueString(variant, "barcode"),
            PrePackedItem = getJObjectValueString(variant, "pre-packed", VariantDTO.defaultPrePackedItem),
            VariantDescription = getJObjectValueString(variant, "variant description") ?? "",
            Composition = getJObjectValueString(variant, "composition") ?? "",
            Hscode = getJObjectValueString(variant, "hscode"),
            Country = getJObjectValueString(variant, "country"),
            Gender = getJObjectValueString(variant, "gender"),
            AgeGroup = getJObjectValueString(variant, "agegroup"),
            Color = getJObjectValueString(variant, "color"),
            Size = getJObjectValueString(variant, "size"),
            Fabric = getJObjectValueString(variant, "fabric"),
            Width = getJObjectValueDouble(variant, "width"),
            Height = getJObjectValueDouble(variant, "height"),
            Depth = getJObjectValueDouble(variant, "depth"),
            Weight = getJObjectValueDouble(variant, "weight"),
            PriceRetail = getJObjectValueDouble(variant, "price b2b"),
            PriceWholesale = getJObjectValueDouble(variant, "price b2c"),
            Cost = getJObjectValueDouble(variant, "cost"),
            Currency = getJObjectValueString(variant, "currency"),
            Dangerous = getJObjectValueInt(variant, "dangerous class"),
            UN = getJObjectValueInt(variant, "un number"),
            PackingCode = getJObjectValueInt(variant, "packaging code"),
        };
    }
    public static bool isEmptyToken(JObject obj, string key)
    {
        return obj[key]?.ToString() == "";
    }
    public static string? getJObjectValueString(JObject obj, string key, string? defaultValue = null)
    {
        return isEmptyToken(obj, key) ? defaultValue : obj[key]?.ToString();
    }
    public static int? getJObjectValueInt(JObject obj, string key, int? defaultValue = null)
    {
        return isEmptyToken(obj, key) ? defaultValue : Convert.ToInt32(obj[key]?.ToString());
    }
    public static double? getJObjectValueDouble(JObject obj, string key, double? defaultValue = null)
    {
        return isEmptyToken(obj, key) ? defaultValue : Convert.ToDouble(obj[key]?.ToString());
    }
}