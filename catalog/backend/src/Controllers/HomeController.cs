namespace Src.Controllers;

using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("/")]
public class HomeController : ControllerBase
{
    [HttpGet(Name = "HealthCheck")]
    public Dictionary<string, string> Get()
    {
        return new Dictionary<string, string>
        {
            { "status", "ok" }
        };
    }
}