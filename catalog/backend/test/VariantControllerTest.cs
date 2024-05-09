using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;

using backend.Models;

using Newtonsoft.Json;

using Xunit;
using Xunit.Extensions.Ordering;

namespace test;

public class VariantFactory : TestingWebAppFactory
{
    protected override void SeedDbForTests(DatabaseContext db)
    {
        // Since we are populating the database in the migration there is no need to populate it here
        // The follow populations will be useful when the migration is not populated
        /*
        db.Variants!.AddRange(new List<Variant>
        {
            new ()
            {
                Id = 1,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008476",
                VariantDescription = "White version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "US",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "USD"
            },
            new ()
            {
                Id = 2,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008477",
                VariantDescription = "Black version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "US",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "USD"
            },
            new ()
            {
                Id = 3,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008478",
                VariantDescription = "Brown version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "US",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "USD"
            },
            new ()
            {
                Id = 4,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008476",
                VariantDescription = "White version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "PT",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "EUR"
            },
            new ()
            {
                Id = 5,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008477",
                VariantDescription = "Black version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "PT",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "EUR"
            },
            new ()
            {
                Id = 6,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008478",
                VariantDescription = "Brown version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "PT",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "EUR"
            },
            new ()
            {
                Id = 7,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "White version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 8,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "Black version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 9,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "Brown version",
                Composition = "100% Leather",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 10,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "White version",
                Composition = "50% Leather, 50% Cotton",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 11,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "Black version",
                Composition = "50% Leather, 50% Cotton",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 12,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "Brown version",
                Composition = "50% Leather, 50% Cotton",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 13,
                ProductId = 3,
                SKU = "DV7119-222",
                Barcode = "5234426937376",
                VariantDescription = "Blue version",
                Composition = "10% Cotton, 90% Polyamide",
                Hscode = "64031900",
                Country = "US",
                Width = 4,
                Height = 4,
                Depth = 27,
                Weight = 0.6,
                Currency = "USD"
            },
            new ()
            {
                Id = 14,
                ProductId = 4,
                SKU = "DV4519-222",
                Barcode = "5947420582976",
                VariantDescription = "Blue version",
                Composition = "100% Cotton",
                Hscode = "64031900",
                Country = "FR",
                Width = 5,
                Height = 10,
                Depth = 1,
                Weight = 0.6,
                Currency = "EUR"
            },
            new ()
            {
                Id = 15,
                ProductId = 5,
                SKU = "DV4519-222",
                Barcode = "1237493750276",
                VariantDescription = "Green version",
                Composition = "100% Rubber",
                Hscode = "34631920",
                Country = "BZ",
                Width = 5,
                Height = 20,
                Depth = 1,
                Weight = 0.6,
                Currency = "BRL"
            },
            new ()
            {
                Id = 16,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008476",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "US",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "USD"
            },
            new ()
            {
                Id = 17,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008477",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "US",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "USD"
            },
            new Variant
            {
                Id = 18,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008478",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "US",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "USD"
            },
            new ()
            {
                Id = 19,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008476",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "EUR"
            },
            new ()
            {
                Id = 20,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008477",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "EUR"
            },
            new ()
            {
                Id = 21,
                ProductId = 1,
                SKU = "tra/nik/whi/lea",
                Barcode = "5714326008478",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 5,
                Height = 6,
                Depth = 25,
                Weight = 0.74,
                Currency = "EUR"
            },
            new ()
            {
                Id = 22,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 23,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 24,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 25,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 26,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 27,
                ProductId = 2,
                SKU = "DV7129-222",
                Barcode = "5214426038376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "PT",
                Width = 4,
                Height = 5,
                Depth = 30,
                Weight = 0.8,
                Currency = "EUR"
            },
            new ()
            {
                Id = 28,
                ProductId = 3,
                SKU = "DV7119-222",
                Barcode = "5234426937376",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "US",
                Width = 4,
                Height = 4,
                Depth = 27,
                Weight = 0.6,
                Currency = "USD"
            },
            new ()
            {
                Id = 29,
                ProductId = 4,
                SKU = "DV4519-222",
                Barcode = "5947420582976",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "64031900",
                Country = "FR",
                Width = 5,
                Height = 10,
                Depth = 1,
                Weight = 0.6,
                Currency = "EUR"
            },
            new ()
            {
                Id = 30,
                ProductId = 5,
                SKU = "DV4519-222",
                Barcode = "1237493750276",
                VariantDescription = "DS version",
                Composition = "100% Pain",
                Hscode = "34631920",
                Country = "BZ",
                Width = 5,
                Height = 20,
                Depth = 1,
                Weight = 0.6,
                Currency = "BRL"
            }
        });
        db.SaveChanges();*/
    }
}

public class VariantControllerTest : IClassFixture<VariantFactory>
{
    private class ErrorVariantPagesResponse
    {
        public int pages { get; set; }
        public string? error { get; set; }
    }

    private class ErrorVariantsResponse
    {
        public dynamic? variants { get; set; }
        public string? error { get; set; }
    }

    private readonly HttpClient _client;

    public VariantControllerTest(VariantFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact, Order(0)]
    public async Task GetVariants()
    {
        var response = await _client.GetAsync("/variants?pageSize=5");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, IEnumerable<Variant>>>(stringResponse);

        Assert.Equal(5, result!["variants"].Count());
    }

    [Fact]
    public async Task GetVariantsPaginated()
    {
        var response = await _client.GetAsync("/variants?pageSize=5&pageNumber=2");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, IEnumerable<Variant>>>(stringResponse);

        Assert.Equal(6, result!["variants"].First().Id);
    }

    [Fact]
    public async Task GetVariantsPaginatedWrong()
    {
        var response = await _client.GetAsync("/variants?pageNumber=0");
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<ErrorVariantsResponse>(stringResponse);

        Assert.Equal("Page number must be greater than 0", result!.error);
    }

    [Fact]
    public async Task GetPagesNumber()
    {
        var response = await _client.GetAsync("/variants/pages?pageSize=50");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, int>>(stringResponse);

        Assert.Equal(1, result!["pages"]);
    }

    [Fact]
    public async Task GetPagesNumberWrong()
    {
        var response = await _client.GetAsync("/variants/pages?pageSize=-1");
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<ErrorVariantPagesResponse>(stringResponse);

        Assert.Equal("Page size must be greater than 0", result!.error);
    }

    [Fact]
    public async Task GetVariantsSearchPuma()
    {
        var response = await _client.GetAsync("/variants?pageSize=50&q=puma");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, IEnumerable<Variant>>>(stringResponse);

        Assert.Equal(2, result!["variants"].Count());
    }

    [Fact]
    public async Task GetVariantsSearchLeather()
    {
        var response = await _client.GetAsync("/variants?pageSize=50&q=leather");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, IEnumerable<Variant>>>(stringResponse);

        Assert.Equal(12, result!["variants"].Count());
    }

    [Fact]
    public async Task GetVariantsSearchNone()
    {
        var response = await _client.GetAsync("/variants?pageSize=50&q=sdufhushf");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, IEnumerable<Variant>>>(stringResponse);

        Assert.Empty(result!["variants"]);
    }

    [Fact, Order(1)]
    public async Task GetVariantById()
    {
        var response = await _client.GetAsync("/variants/1");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Variant>>(stringResponse);
        var variant = result!["variant"];
        Assert.NotNull(variant);
        Assert.Equal(1, variant!.Id);
    }

    [Fact, Order(3)]
    public async Task CreateVariant()
    {
        var variant = new VariantDTO
        {
            ProductId = 1,
            SKU = "sku",
            Barcode = "barcode",
            VariantDescription = "description",
            Composition = "composition",
            Hscode = "hscode",
            Country = "PT",
            Width = 1,
            Height = 1,
            Depth = 1,
            Weight = 1,
            Currency = "AED"
        };

        var response = await _client.PostAsJsonAsync("/variants/add", variant);
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Variant>(stringResponse);
        Assert.NotNull(result);
        Assert.Equal(31, result!.Id);
    }

    [Fact, Order(4)]
    public async Task EditVariant()
    {
        var variantDTO = new VariantDTO
        {
            ProductId = 1,
            SKU = "sku",
            Barcode = "barcode",
            VariantDescription = "description",
            Composition = "composition",
            Hscode = "hscode",
            Country = "PT",
            Width = 1,
            Height = 1,
            Depth = 1,
            Weight = 1,
            Currency = "AED"
        };

        var putResponse = await _client.PutAsJsonAsync("/variants/1", variantDTO);
        putResponse.EnsureSuccessStatusCode();

        var getResponse = await _client.GetAsync("/variants/1");
        getResponse.EnsureSuccessStatusCode();
        var stringResponse = await getResponse.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Variant>>(stringResponse);
        var variant = result!["variant"];
        Assert.Equal("sku", variant.SKU);
    }

    [Fact, Order(5)]
    public async Task ArchiveVariant()
    {
        var archive = new IsArchivedDTO { IsArchived = true };
        var response = await _client.PostAsJsonAsync("/variants/archive/1", archive);
        response.EnsureSuccessStatusCode();

        var getResponse = await _client.GetAsync("/variants/1");
        getResponse.EnsureSuccessStatusCode();
        var stringResponse = await getResponse.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Variant>>(stringResponse);
        var variant = result!["variant"];
        Assert.True(variant.IsArchived);
    }

    [Fact]
    public async Task GetTemplate()
    {
        var response = await _client.GetAsync("/variants/template");
        response.EnsureSuccessStatusCode();
        var stringResponse = await response.Content.ReadAsStringAsync();

        // if an error occured the response will be a json with the error message
        // otherwise it will be a .xls file in a byte array
        // so the json parse should throw an exception if the response is a file
        Assert.Throws<JsonReaderException>(() =>
            JsonConvert.DeserializeObject<Dictionary<string, string>>(stringResponse));
    }
}