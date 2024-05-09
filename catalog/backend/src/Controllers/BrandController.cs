using backend.Common;
using backend.Models;

using FluentValidation;
using FluentValidation.Results;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers;

[ApiController]
[Route("/brands")]
public class BrandController : ControllerBase
{
    private readonly DatabaseContext _context;

    public BrandController(DatabaseContext context)
    {
        this._context = context;
    }

    [HttpGet(Name = "GetBrands")]
    public IActionResult Get()
    {
        var brands = _context.Brands?
                        .Select(brand => new
                        {
                            brand.Id,
                            brand.Name,
                            ProductIds = brand.Products.Select(product => product.Id)
                        })
                        .OrderBy(brand => brand.Name).ToList();

        if (brands == null)
        {
            return NotFound(new { brands = new List<Variant>(), error = "No brands found" });
        }

        return Ok(new { brands = brands });
    }

    [HttpGet("{id}", Name = "GetBrand")]
    public IActionResult Get(int id)
    {
        var brand = _context.Brands?.Include(brand => brand.Products).Where(brand => brand.Id == id).FirstOrDefault();

        if (brand == null)
        {
            return NotFound(new { brand = new { }, error = "No Brand found with Id " + id });
        }

        var brandWithProductIds = new
        {
            brand.Id,
            brand.Name,
            ProductIds = brand.Products.Select(product => product.Id)
        };

        return Ok(new { brand = brandWithProductIds });
    }

    [HttpPost("add", Name = "CreateBrand")]
    public async Task<IActionResult> Post([FromBody] BrandDTO brandDTO, [FromServices] IValidator<Brand> validator)
    {
        var brand = new Brand(brandDTO);

        var brandValidation = RoutesUtils.Validate(validator, brand);
        if (brandValidation != null) return ValidationProblem(brandValidation);

        _context.Brands?.Add(brand);
        await _context.SaveChangesAsync();

        return CreatedAtRoute("GetBrand", new { id = brand.Id }, brand);
    }
}