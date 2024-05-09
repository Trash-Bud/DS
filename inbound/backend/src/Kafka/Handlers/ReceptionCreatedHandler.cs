using System.Text.Json;

using backend.Models;
using backend.Models.Kafka;

using Microsoft.EntityFrameworkCore;

namespace backend.Kafka.Handlers;

public class ReceptionCreatedHandler : KafkaHandler<ReceptionCreated>
{
    public ReceptionCreatedHandler(IServiceProvider serviceProvider) : base(serviceProvider)
    {
    }

    public override void Handle(ReceptionCreated message)
    {
        using var scope = this._serviceProvider.CreateScope();
        DatabaseContext context = scope.ServiceProvider.GetService<DatabaseContext>()!;
        DbSet<ReceptionCreated> dbSet = context.Set<ReceptionCreated>();

        dbSet.Add(message);
        context.SaveChanges();
    }

}