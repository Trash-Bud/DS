using System.Text.Json;

using backend.Models;
using backend.Models.Kafka;

using Microsoft.EntityFrameworkCore;

namespace backend.Kafka.Handlers;

public class ReceptionReceivedHandler : KafkaHandler<ReceptionReceived>
{
    public ReceptionReceivedHandler(IServiceProvider serviceProvider) : base(serviceProvider)
    {
    }

    public override void Handle(ReceptionReceived message)
    {
        using var scope = this._serviceProvider.CreateScope();
        DatabaseContext context = scope.ServiceProvider.GetService<DatabaseContext>()!;
        DbSet<ReceptionReceived> dbSet = context.Set<ReceptionReceived>();

        dbSet.Add(message);
        // update ASN status
        ASN asn = context.ASNs.Find(message.AsnId);
        if (asn != null && asn.State == ASNState.Booked)
        {
            asn.State = ASNState.Received;
            asn.ReceptionReceivedId = message.Id;
            asn.ReceptionReceived = message;
        }

        context.SaveChanges();
    }

}