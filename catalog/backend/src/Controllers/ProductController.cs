using backend.Common;
using backend.Models;

using FluentValidation;

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers;

[ApiController]
[Route("/products")]
public class ProductController : ControllerBase
{
    private readonly DatabaseContext _context;

    public ProductController(DatabaseContext context)
    {
        this._context = context;
    }

    [HttpGet(Name = "GetProducts")]
    public IActionResult Get()
    {
        var products = _context.Products?
                    .Select(product => new
                    {
                        product.Id,
                        // TODO: is there a way to list the Ids "automatically"?
                        VariantsIds = product.Variants.Select(variant => variant.Id),
                        product.BrandId,
                        product.Name,
                        product.Description,
                        product.Season,
                        product.Supplier,
                        product.Type,
                        product.Family,
                        product.SubFamily
                    })
                    .OrderBy(product => product.Name).ToList();

        if (products == null)
        {
            return NotFound(new { products = new List<Product>(), error = "No Products found" });
        }

        return Ok(new { products = products });
    }

    [HttpGet("{id}", Name = "GetProduct")]
    public IActionResult Get(int id)
    {
        var product = _context.Products?.Include(product => product.Variants).Where(product => product.Id == id).FirstOrDefault();
        if (product == null)
        {
            return NotFound(new { product = new { }, error = "No Product found with Id " + id });
        }

        var productWithVariantsIds = new
        {
            product.Id,
            VariantsIds = product.Variants.Select(variant => variant.Id),
            product.BrandId,
            product.Name,
            product.Description,
            product.Season,
            product.Supplier,
            product.Type,
            product.Family,
            product.SubFamily
        };

        return Ok(new { product = productWithVariantsIds });
    }

    [HttpPost("add", Name = "CreateProduct")]
    public async Task<IActionResult> Post(int brandId, [FromBody] ProductDTO productDTO, [FromServices] IValidator<Product> validator)
    {
        var product = new Product(productDTO, brandId);

        var productValidation = RoutesUtils.Validate(validator, product);
        if (productValidation != null) return ValidationProblem(productValidation);

        _context.Products?.Add(product);
        await _context.SaveChangesAsync();

        return CreatedAtRoute("GetProduct", new { id = product.Id }, product);
    }

    [HttpGet("{id}/variants", Name = "GetProductVariants")]
    public IActionResult GetProductVariants(int id)
    {
        var product = _context.Products?.Include(product => product.Variants).Where(product => product.Id == id).FirstOrDefault();

        if (product == null)
        {
            return NotFound(new { variants = new List<Variant>(), error = "No Product found with Id " + id });
        }

        return Ok(new { variants = product.Variants });
    }

    [HttpPut("{productId}", Name = "EditProduct")]
    [Consumes("application/json")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public IActionResult EditProduct(int productId, [FromBody] ProductDTO productDTO, [FromServices] IValidator<Product> validator)
    {
        var product = _context.Products?.Find(productId);
        if (product == null)
        {
            return NotFound(new { product = new { }, error = "No Product found with Id " + productId });
        }

        var newProduct = new Product(productId, productDTO, product.BrandId);
        var productValidation = RoutesUtils.Validate(validator, newProduct);
        if (productValidation != null) return ValidationProblem(productValidation);

        _context.Entry(product).CurrentValues.SetValues(newProduct);
        _context.SaveChanges();
        return Ok();
    }

}