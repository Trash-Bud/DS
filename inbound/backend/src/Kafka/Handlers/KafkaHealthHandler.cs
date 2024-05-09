using backend.Models;

using Microsoft.EntityFrameworkCore;

namespace backend.Kafka.Handlers;

public class KafkaHealthHandler : KafkaHandler<KafkaHealthCheck>
{
    public KafkaHealthHandler(IServiceProvider serviceProvider) : base(serviceProvider)
    {
    }

    public override void Handle(KafkaHealthCheck message)
    {
        using var scope = this._serviceProvider.CreateScope();
        DatabaseContext context = scope.ServiceProvider.GetService<DatabaseContext>()!;
        DbSet<KafkaHealthCheck> dbSet = context.Set<KafkaHealthCheck>();

        dbSet.Add(message);
        context.SaveChanges();
    }
}