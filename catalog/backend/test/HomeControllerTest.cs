using System.Net.Http;
using System.Threading.Tasks;

using Newtonsoft.Json.Linq;

using Xunit;

namespace test;

public class HomeControllerTest : IClassFixture<TestingWebAppFactory>
{
    private readonly HttpClient _client;
    public HomeControllerTest(TestingWebAppFactory factory)
        => _client = factory.CreateClient();

    [Fact]
    public async Task LifeCheck()
    {
        var response = await _client.GetAsync("/");
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();
        JObject json = JObject.Parse(responseString);
        Assert.Equal("ok", json["status"]!.Value<string>());
    }
}