namespace backend.Controllers;

using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("/")]
public class HomeController : ControllerBase
{
    [HttpGet(Name = "Life Check")]
    public Dictionary<string, bool> Get()
    {
        return new Dictionary<string, bool>
        {
            ["online"] = true
        };
    }
}