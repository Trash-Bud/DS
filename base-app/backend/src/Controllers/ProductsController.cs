using backend.Models;

using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("/products")]
public class ProductsController : ControllerBase
{
    [HttpGet(Name = "MockProducts")]
    public Dictionary<string, List<ProductModel>> Get()
    {
        var context = new DatabaseContext();
        var products = context.Products?.ToList();
        return new Dictionary<string, List<ProductModel>>
        {
            ["products"] = products ?? new List<ProductModel>()
        };
    }
}