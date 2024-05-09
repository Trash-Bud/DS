using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

using backend.Models;

using Newtonsoft.Json;

using OfficeOpenXml;

using Xunit;
using Xunit.Extensions.Ordering;

namespace integration_tests;

public class AsnFactory : TestingWebAppFactory
{
    protected override void SeedDbForTests(DatabaseContext db)
    {
        db.ASNs!.AddRange(new List<ASN>
            {
                new()
                {
                    Id = 1,
                    ShipmentReference = "ASN-1",
                    Warehouse = "Test Warehouse",
                    ExpectedDeliveryDate = DateTime.Parse("2021-01-01T00:00:00"),
                    CarrierName = "UPS",
                    State = ASNState.Received
                },
                new()
                {
                    Id = 2,
                    ShipmentReference = "ASN-2",
                    Warehouse = "Amazon Storage",
                    ExpectedDeliveryDate = DateTime.Parse("2021-01-01T00:00:00"),
                    PurchaseOrderId = 2,
                    CarrierName = "FedEx",
                    State = ASNState.Pending
                },
            });
        db.SaveChanges();
    }
}

[Order(1)]
public class AsnIT : IClassFixture<AsnFactory>
{
    private readonly HttpClient _client;

    public AsnIT(AsnFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact, Order(0)]
    public async Task GetASNs()
    {
        var response = await _client.GetAsync("/asn");
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        IEnumerable<ASN> asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<ASN> collection = asns as ASN[] ?? asns.ToArray();
        Assert.Equal(2, collection.Count());
        Assert.Equal(2, totalResults);
    }

    [Fact, Order(1)]
    public async Task GetASN()
    {
        var response = await _client.GetAsync("/asn/1");
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var asn = JsonConvert.DeserializeObject<ASN>(responseString);
        Assert.Equal("ASN-1", asn.ShipmentReference);
        Assert.Equal("Test Warehouse", asn.Warehouse);
        Assert.Equal(DateTime.Parse("2021-01-01T00:00:00"), asn.ExpectedDeliveryDate);
        Assert.Null(asn.PurchaseOrderId);
    }

    [Fact, Order(2)]
    public async Task GetASNNotFound()
    {
        var response = await _client.GetAsync("/asn/3");
        Assert.Equal(System.Net.HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No ASN found with ID 3", result["error"]);
    }

    [Fact, Order(3)]
    public async Task GetFilteredByQueryASNs()
    {
        // Get all ASNs with a specific Shipment Reference
        var response = await _client.GetAsync($"/asn?query=ASN-1");
        response.EnsureSuccessStatusCode();
        var responseString = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        IEnumerable<ASN> asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);
        IEnumerable<ASN> collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal(1, collection.First().Id);
        Assert.Equal(1, totalResults);

        // Get all ASNs with a specific Warehouse Name
        response = await _client.GetAsync($"/asn?query=Amazon");
        response.EnsureSuccessStatusCode();
        responseString = await response.Content.ReadAsStringAsync();
        result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        totalResults = Convert.ToInt32(result["totalResults"]);
        collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal(2, collection.First().Id);
        Assert.Equal(1, totalResults);

        // Get all ASNs with a specific Carrier Name
        response = await _client.GetAsync($"/asn?query=UPS");
        response.EnsureSuccessStatusCode();
        responseString = await response.Content.ReadAsStringAsync();
        result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        totalResults = Convert.ToInt32(result["totalResults"]);
        collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal(1, collection.First().Id);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(4)]
    public async Task GetFilteredByStateASNs()
    {
        // Test valid state
        var response = await _client.GetAsync($"/asn?state=Received");
        response.EnsureSuccessStatusCode();
        var responseString = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        IEnumerable<ASN> asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);
        IEnumerable<ASN> collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal(1, collection.First().Id);
        Assert.Equal(1, totalResults);

        // Confirm that sending an invalid state returns an HTTP 400 
        response = await _client.GetAsync($"/asn?state=InvalidState");
        Assert.Equal(System.Net.HttpStatusCode.BadRequest, response.StatusCode);
    }

    [Fact, Order(5)]
    public async Task GetFilteredByAllASNs()
    {
        // Test fetching ASNs with a certain Shipment Reference and a certain State
        var response = await _client.GetAsync($"/asn?query=ASN-1&state=Received");
        response.EnsureSuccessStatusCode();
        var responseString = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        IEnumerable<ASN> asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);
        IEnumerable<ASN> collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal(1, collection.First().Id);
        Assert.Equal(1, totalResults);

        // Test fetching ASNs with a combination of Shipment Reference and State that doesn't exist
        response = await _client.GetAsync($"/asn?query=ASN-2&state=Received");
        response.EnsureSuccessStatusCode();
        responseString = await response.Content.ReadAsStringAsync();
        result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(responseString);
        asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        totalResults = Convert.ToInt32(result["totalResults"]);

        collection = asns as ASN[] ?? asns.ToArray();
        Assert.Empty(collection);
        Assert.Equal(0, totalResults);
    }

    [Fact, Order(6)]
    public async Task GetASNs_Limit()
    {
        var response = await _client.GetAsync("/asn?limit=1");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<ASN> asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<ASN> collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal("ASN-1", collection.First().ShipmentReference);
        Assert.Equal(2, totalResults);
    }

    [Fact, Order(7)]
    public async Task GetASNs_Offset()
    {
        var response = await _client.GetAsync("/asn?offset=1");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<ASN> asns = JsonConvert.DeserializeObject<IEnumerable<ASN>>(
            JsonConvert.SerializeObject(result["asn"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<ASN> collection = asns as ASN[] ?? asns.ToArray();
        Assert.Single(collection);
        Assert.Equal("ASN-2", collection.First().ShipmentReference);
        Assert.Equal(2, totalResults);
    }

    [Fact, Order(8)]
    public async Task CreateASN()
    {
        var asn = new ASN
        {
            ShipmentReference = "ASN-3",
            Warehouse = "Test Warehouse",
            ExpectedDeliveryDate = DateTime.Parse("2021-01-01T00:00:00"),
        };

        var response = await _client.PostAsync("/asn", new StringContent(JsonConvert.SerializeObject(asn), Encoding.UTF8, "application/json"));
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var createdAsn = JsonConvert.DeserializeObject<ASN>(responseString);
        Assert.Equal("ASN-3", createdAsn.ShipmentReference);
        Assert.Equal("Test Warehouse", createdAsn.Warehouse);
        Assert.Equal(DateTime.Parse("2021-01-01T00:00:00"), createdAsn.ExpectedDeliveryDate);
        Assert.Null(createdAsn.PurchaseOrderId);
    }

    [Fact, Order(9)]
    public async Task CreateASNWithPurchaseOrder()
    {
        var asn = new ASN
        {
            ShipmentReference = "ASN-4",
            Warehouse = "Test Warehouse",
            ExpectedDeliveryDate = DateTime.Parse("2021-01-01T00:00:00"),
            PurchaseOrderId = 1,
        };

        var response = await _client.PostAsync("/asn", new StringContent(JsonConvert.SerializeObject(asn), Encoding.UTF8, "application/json"));
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var createdAsn = JsonConvert.DeserializeObject<ASN>(responseString);
        Assert.Equal("ASN-4", createdAsn.ShipmentReference);
        Assert.Equal("Test Warehouse", createdAsn.Warehouse);
        Assert.Equal(DateTime.Parse("2021-01-01T00:00:00"), createdAsn.ExpectedDeliveryDate);
        Assert.Equal(1, createdAsn.PurchaseOrderId);

        var purchaseOrderResponse = await _client.GetAsync("/purchase-orders/1");
        purchaseOrderResponse.EnsureSuccessStatusCode();

        var purchaseOrderResponseString = await purchaseOrderResponse.Content.ReadAsStringAsync();


        var purchaseOrder = JsonConvert.DeserializeObject<PurchaseOrder>(purchaseOrderResponseString);
        Assert.Single(purchaseOrder.ASNs);
    }

    [Fact, Order(10)]
    public async Task GetASNFile()
    {
        var response = await _client.GetAsync("/asn/3/export");
        response.EnsureSuccessStatusCode();

        var responseByteArray = await response.Content.ReadAsByteArrayAsync();

        using (MemoryStream ms = new MemoryStream(responseByteArray))
        {
            using (ExcelPackage package = new ExcelPackage(ms))
            {
                Assert.True(package.Workbook.Worksheets.Count > 0, "The xlsx file should have at least one sheet");
                ExcelWorksheet sheet = package.Workbook.Worksheets[0];

                Assert.Equal("Shipment reference", sheet.Cells[1, 1].Value);
                Assert.Equal("Shipping from address", sheet.Cells[1, 2].Value);
                Assert.Equal("Shipping to Warehouse", sheet.Cells[1, 3].Value);
                Assert.Equal("Expected delivery date", sheet.Cells[1, 4].Value);
                Assert.Equal("Carrier name", sheet.Cells[1, 5].Value);
                Assert.Equal("Cargo type", sheet.Cells[1, 6].Value);
                Assert.Equal("Shipper contact", sheet.Cells[1, 7].Value);
                Assert.Equal("Purchase order number", sheet.Cells[1, 8].Value);
                Assert.Equal("Purchase order date", sheet.Cells[1, 9].Value);
                Assert.Equal("Product code", sheet.Cells[1, 10].Value);
                Assert.Equal("Quantity", sheet.Cells[1, 11].Value);
            }
        }
    }

    [Fact, Order(11)]
    public async Task GetASNFileNotFound()
    {
        var response = await _client.GetAsync("/asn/28128123/export");
        Assert.Equal(System.Net.HttpStatusCode.NotFound, response.StatusCode);
    }

    [Fact, Order(12)]
    public async Task CancelASNNotFound()
    {
        var response = await _client.PutAsync("/asn/28128123/cancel", null);
        Assert.Equal(System.Net.HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No ASN found with ID 28128123", result["error"]);
    }

    [Fact, Order(13)]
    public async Task BookASN()
    {
        var response = await _client.PutAsync("/asn/3/book", null);
        response.EnsureSuccessStatusCode();

        // convert result to ASN and verify the status
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<ASN>(stringResponse);
        Assert.Equal(3, result.Id);
        Assert.Equal(ASNState.Booked, result.State);
    }

    [Fact, Order(14)]
    public async Task BookASNNotFound()
    {
        var response = await _client.PutAsync("/asn/28128123/book", null);
        Assert.Equal(System.Net.HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No ASN found with that ID", result["error"]);
    }

    [Fact, Order(15)]
    public async Task EditASN()
    {
        var asn = new ASN
        {
            ShipmentReference = "ASN-3",
            Warehouse = "New Test Warehouse",
            ExpectedDeliveryDate = DateTime.Parse("2021-01-01T00:00:00"),
            CarrierName = "New Test Carrier",
        };

        var response = await _client.PutAsync("/asn/3", new StringContent(JsonConvert.SerializeObject(asn), Encoding.UTF8, "application/json"));
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var createdAsn = JsonConvert.DeserializeObject<ASN>(responseString);
        Assert.Equal("ASN-3", createdAsn.ShipmentReference);
        Assert.Equal("New Test Warehouse", createdAsn.Warehouse);
        Assert.Equal(DateTime.Parse("2021-01-01T00:00:00"), createdAsn.ExpectedDeliveryDate);
        Assert.Equal("New Test Carrier", createdAsn.CarrierName);
    }

    [Fact, Order(16)]
    public async Task EditASNAddress()
    {
        var asn = new ASN
        {
            ShipmentReference = "ASN-3",
            Warehouse = "New Test Warehouse",
            ExpectedDeliveryDate = DateTime.Parse("2021-01-01T00:00:00"),
            CarrierName = "New Test Carrier",
            Address = "Test Address",
        };

        var response = await _client.PutAsync("/asn/3", new StringContent(JsonConvert.SerializeObject(asn), Encoding.UTF8, "application/json"));
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var createdAsn = JsonConvert.DeserializeObject<ASN>(responseString);
        Assert.Equal("ASN-3", createdAsn.ShipmentReference);
        Assert.Equal("New Test Warehouse", createdAsn.Warehouse);
        Assert.Equal(DateTime.Parse("2021-01-01T00:00:00"), createdAsn.ExpectedDeliveryDate);
        Assert.Equal("New Test Carrier", createdAsn.CarrierName);
        Assert.Equal("Test Address", createdAsn.Address);
    }

    [Fact, Order(17)]
    public async Task ReceiveASN()
    {
        var response = await _client.PutAsync("/asn/3/receive", null);
        response.EnsureSuccessStatusCode();

        // convert result to ASN and verify the status
        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<ASN>(stringResponse);
        Assert.Equal(3, result.Id);
        Assert.Equal(ASNState.Received, result.State);
    }

    [Fact, Order(18)]
    public async Task ReceiveASNNotFound()
    {
        var response = await _client.PutAsync("/asn/28128123/receive", null);
        Assert.Equal(System.Net.HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No ASN found with that ID", result["error"]);
    }
}