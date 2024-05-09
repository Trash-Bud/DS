using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

using backend.Models;
using backend.Models.Kafka;

using Newtonsoft.Json;

using Xunit;
using Xunit.Extensions.Ordering;

namespace integration_tests;

public class ReceptionCreatedFactory : TestingWebAppFactory
{
    protected override void SeedDbForTests(DatabaseContext db)
    {
        db.KafkaReceptionCreateds!.AddRange(new List<ReceptionCreated>
        {
            new()
            {
                Id = 1,
                AsnId = 1,
            },
        });
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
        }); db.SaveChanges();
    }
}

[Order(2)]
public class ReceptionCreatedIT : IClassFixture<ReceptionCreatedFactory>
{
    private readonly HttpClient _client;

    public ReceptionCreatedIT(ReceptionCreatedFactory factory)
    {
        _client = factory.CreateClient();
    }

    [Fact, Order(0)]
    public async Task GetReceptionsCreated()
    {
        var response = await _client.GetAsync("/kafka/receptions-created");
        response.EnsureSuccessStatusCode();

        var responseString = await response.Content.ReadAsStringAsync();

        var receptionsCreatedList =
            JsonConvert.DeserializeObject<List<ReceptionCreated>>(responseString)!;

        Assert.Single(receptionsCreatedList);

        var receptionCreated = receptionsCreatedList.First();

        Assert.Equal(1, receptionCreated.Id);
        Assert.Equal(1, receptionCreated.AsnId);
        Assert.Equal("ASN-1", receptionCreated.Asn!.ShipmentReference);
    }

    /*
    [Fact, Order(1)]
    public async Task CreateReceptionCreate()
    {
        var postResponse = await _client.PostAsync("/kafka/reception-created/3", null);
        postResponse.EnsureSuccessStatusCode();

        await postResponse.Content.ReadAsStringAsync();

        var getResponse = await _client.GetAsync("/kafka/receptions-created");
        getResponse.EnsureSuccessStatusCode();

        var getResponseString = await getResponse.Content.ReadAsStringAsync();

        var receptionsCreatedList =
            JsonConvert.DeserializeObject<List<ReceptionCreated>>(getResponseString);

        var newReceptionCreated = receptionsCreatedList!.Last();

        Assert.Equal(2, newReceptionCreated.Id);
        Assert.Equal(2, newReceptionCreated.AsnId);
        Assert.Equal("ASN-2", newReceptionCreated.Asn!.ShipmentReference);
    }*/

}