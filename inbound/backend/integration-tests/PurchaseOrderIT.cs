using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

using backend.Models;

using Newtonsoft.Json;

using Xunit;
using Xunit.Extensions.Ordering;

namespace integration_tests;

public class PurchaseOrderFactory : TestingWebAppFactory
{
    protected override void SeedDbForTests(DatabaseContext db)
    {
        db.PurchaseOrders!.AddRange(new List<PurchaseOrder>
        {
            new()
            {
                Id = 1,
                PoIdentification = "PO-1",
                State = PurchaseOrderState.Archived,
                Name = "Test Purchase Order",
                Supplier = "Test Supplier",
                ReceivedItems = 0,
                TotalItems = 10,
            },
            new()
            {
                Id = 2,
                PoIdentification = "PO-2",
                State = PurchaseOrderState.Cancelled,
                Name = "Another Purchase Order",
                Supplier = "Nice Supplier",
                ReceivedItems = 4,
                TotalItems = 10,
            }
        });
        db.SaveChanges();
    }
}

[Order(0)]
public class PurchaseOrderIT : IClassFixture<PurchaseOrderFactory>
{
    private readonly HttpClient _client;

    public PurchaseOrderIT(PurchaseOrderFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact, Order(0)]
    public async Task GetPurchaseOrders_NoFilters()
    {
        var response = await _client.GetAsync("/purchase-orders");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);
        Assert.Equal(2, purchaseOrders.Count());
        Assert.Equal(2, totalResults);
    }

    [Fact, Order(1)]
    public async Task GetPurchaseOrders_NameQuery()
    {
        var response = await _client.GetAsync("/purchase-orders?query=Test Purchase Order");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-1", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(2)]
    public async Task GetPurchaseOrders_IncompleteNameQuery()
    {
        var response = await _client.GetAsync("/purchase-orders?query=another purchase");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-2", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(3)]
    public async Task GetPurchaseOrders_SupplierQuery()
    {
        var response = await _client.GetAsync("/purchase-orders?query=Nice Supplier");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-2", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(4)]
    public async Task GetPurchaseOrders_IncompleteSupplierQuery()
    {
        var response = await _client.GetAsync("/purchase-orders?query=Nice");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-2", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(5)]
    public async Task GetPurchaseOrders_IdQuery()
    {
        var response = await _client.GetAsync("/purchase-orders?query=PO-1");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-1", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(6)]
    public async Task GetPurchaseOrders_IncompleteIdQuery()
    {
        var response = await _client.GetAsync("/purchase-orders?query=O-1");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Empty(collection);
        Assert.Equal(0, totalResults);
    }

    [Fact, Order(7)]
    public async Task GetPurchaseOrders_StateFilter()
    {
        var response = await _client.GetAsync("/purchase-orders?state=Cancelled");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-2", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(8)]
    public async Task GetPurchaseOrders_StateAndQueryFilter()
    {
        var response = await _client.GetAsync("/purchase-orders?state=Cancelled&query=Another Purchase Order");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-2", collection.First().PoIdentification);
        Assert.Equal(1, totalResults);
    }

    [Fact, Order(9)]
    public async Task GetPurchaseOrders_Limit()
    {
        var response = await _client.GetAsync("/purchase-orders?limit=1");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-1", collection.First().PoIdentification);
        Assert.Equal(2, totalResults);
    }

    [Fact, Order(10)]
    public async Task GetPurchaseOrders_Offset()
    {
        var response = await _client.GetAsync("/purchase-orders?offset=1");
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        IEnumerable<PurchaseOrder> purchaseOrders = JsonConvert.DeserializeObject<IEnumerable<PurchaseOrder>>(
            JsonConvert.SerializeObject(result["purchaseOrders"])
        );
        int totalResults = Convert.ToInt32(result["totalResults"]);

        IEnumerable<PurchaseOrder> collection = purchaseOrders as PurchaseOrder[] ?? purchaseOrders.ToArray();
        Assert.Single(collection);
        Assert.Equal("PO-2", collection.First().PoIdentification);
        Assert.Equal(2, totalResults);
    }


    [Fact, Order(11)]
    public async Task CreatePurchaseOrder_Success()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "New Purchase Order",
            supplier = "Test Supplier",
            totalItems = 10,
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        response.EnsureSuccessStatusCode();

        var stringResponse = await response.Content.ReadAsStringAsync();

        var result = JsonConvert.DeserializeObject<PurchaseOrder>(stringResponse);
        Assert.Equal("New Purchase Order", result.Name);
        Assert.Equal("Test Supplier", result.Supplier);
        Assert.Equal(10, result.TotalItems);
        Assert.Equal(0, result.ReceivedItems);
        Assert.Equal(PurchaseOrderState.Open, result.State);
    }

    [Fact, Order(12)]
    public async Task CreatePurchaseOrder_MissingPoIdentification()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "New Purchase Order",
            supplier = "Test Supplier",
            totalItems = 10
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("PoIdentification"));
        Assert.Single(errors["PoIdentification"]);
        Assert.Equal("Po Identification is required", errors["PoIdentification"].First());
    }

    [Fact, Order(13)]
    public async Task CreatePurchaseOrder_MissingName()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            supplier = "Test Supplier",
            totalItems = 10,
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("Name"));
        Assert.Single(errors["Name"]);
        Assert.Equal("Name is required", errors["Name"].First());
    }

    [Fact, Order(14)]
    public async Task CreatePurchaseOrder_MissingSupplier()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "New Purchase Order",
            totalItems = 10,
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("Supplier"));
        Assert.Single(errors["Supplier"]);
        Assert.Equal("Supplier is required", errors["Supplier"].First());
    }

    [Fact, Order(15)]
    public async Task CreatePurchaseOrder_MissingTotalItems()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "New Purchase Order",
            supplier = "Test Supplier",
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("TotalItems"));
        Assert.Single(errors["TotalItems"]);
        Assert.Equal("Total Items is required", errors["TotalItems"].First());
    }

    [Fact, Order(16)]
    public async Task CreatePurchaseOrder_UniquePoIdentification()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "New Purchase Order",
            supplier = "Test Supplier",
            totalItems = 10,
            poIdentification = "PO-1"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("PoIdentification"));
        Assert.Single(errors["PoIdentification"]);
        Assert.Equal("A PO with that Po Identification already exists", errors["PoIdentification"].First());
    }

    [Fact, Order(17)]
    public async Task CreatePurchaseOrder_NameMaxLength()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = new string('a', 257),
            supplier = "Test Supplier",
            totalItems = 10,
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("Name"));
        Assert.Single(errors["Name"]);
        Assert.Equal("Name must be between 1 and 256 characters", errors["Name"].First());
    }

    [Fact, Order(18)]
    public async Task CreatePurchaseOrder_SupplierMaxLength()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "Name",
            supplier = new string('a', 257),
            totalItems = 10,
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("Supplier"));
        Assert.Single(errors["Supplier"]);
        Assert.Equal("Supplier must be between 1 and 256 characters", errors["Supplier"].First());
    }

    [Fact, Order(19)]
    public async Task CreatePurchaseOrder_TotalItemsPositiveInteger()
    {
        var response = await _client.PostAsync("/purchase-orders/new", new StringContent(JsonConvert.SerializeObject(new
        {
            name = "Name",
            supplier = "Supplier",
            totalItems = -1,
            poIdentification = "PO-3"
        }), Encoding.UTF8, "application/json"));
        Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);
        var errors = JsonConvert.DeserializeObject<Dictionary<string, List<String>>>(
            JsonConvert.SerializeObject(result["errors"])
        );

        Assert.True(errors.ContainsKey("TotalItems"));
        Assert.Single(errors["TotalItems"]);
        Assert.Equal("Total Items must be a positive integer", errors["TotalItems"].First());
    }

    [Fact, Order(20)]
    public async Task GetPurchaseOrder_NotFound()
    {
        var response = await _client.GetAsync("/purchase-orders/123");
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No Purchase order found with ID 123", result["error"]);
    }

    [Fact, Order(21)]
    public async Task GetByPurchaseOrder_NotFound()
    {
        var response = await _client.GetAsync("/purchase-orders/123/asn");
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No Purchase order found with ID 123", result["error"]);
    }

    [Fact, Order(22)]
    public async Task CancelPurchaseOrder_NotFound()
    {
        var response = await _client.PutAsync("/purchase-orders/123/cancel", null);
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No Purchase order found with ID 123", result["error"]);
    }

    [Fact, Order(23)]
    public async Task CancelPurchaseOrder_Archived()
    {
        var response = await _client.PutAsync("/purchase-orders/1/cancel", null);
        Assert.Equal(HttpStatusCode.UnprocessableEntity, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)422, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("Purchase order can't be cancelled because it's archived", result["error"]);
    }

    [Fact, Order(24)]
    public async Task ArchivePurchaseOrder_NotFound()
    {
        var response = await _client.PutAsync("/purchase-orders/123/archive", null);
        Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)404, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("No Purchase order found with ID 123", result["error"]);
    }

    [Fact, Order(25)]
    public async Task ArchivePurchaseOrder_Cancelled()
    {
        var response = await _client.PutAsync("/purchase-orders/2/archive", null);
        Assert.Equal(HttpStatusCode.UnprocessableEntity, response.StatusCode);

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("status"));
        Assert.Equal((Int64)422, result["status"]);
        Assert.True(result.ContainsKey("error"));
        Assert.Equal("Purchase order can't be archived because it's cancelled", result["error"]);
    }

    [Fact, Order(26)]
    public async Task EditPurchaseOrder()
    {
        var newPO = new PurchaseOrder
        {
            Name = "New Name",
            Supplier = "New Supplier",
            TotalItems = 1,
            PoIdentification = "PO-3"
        };

        var response = await _client.PutAsync("/purchase-orders/3", new StringContent(JsonConvert.SerializeObject(newPO), Encoding.UTF8, "application/json"));

        var stringResponse = await response.Content.ReadAsStringAsync();
        var result = JsonConvert.DeserializeObject<Dictionary<string, Object>>(stringResponse);

        Assert.True(result.ContainsKey("id"));
        Assert.Equal((Int64)3, result["id"]);
        Assert.True(result.ContainsKey("name"));
        Assert.Equal("New Name", result["name"]);
        Assert.True(result.ContainsKey("supplier"));
        Assert.Equal("New Supplier", result["supplier"]);
        Assert.True(result.ContainsKey("totalItems"));
        Assert.Equal((Int64)1, result["totalItems"]);
        Assert.True(result.ContainsKey("poIdentification"));
        Assert.Equal("PO-3", result["poIdentification"]);
        Assert.True(result.ContainsKey("state"));
        Assert.Equal("Open", result["state"]);
    }


}