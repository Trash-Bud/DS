using backend.Models.Kafka;

using Microsoft.EntityFrameworkCore;

namespace backend.Models;

public class DatabaseContext : DbContext
{
    public DatabaseContext() { }

    public DatabaseContext(DbContextOptions options)
        : base(options)
    { }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (optionsBuilder.IsConfigured) return;

        var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.local.json", optional: true)
            .Build();
        var databaseHost = configuration.GetSection("database:host").Value;
        var databaseName = configuration.GetSection("database:name").Value;
        var databaseUsername = configuration.GetSection("database:username").Value;
        var databasePassword = configuration.GetSection("database:password").Value;
        optionsBuilder.UseNpgsql($"Host={databaseHost};Database={databaseName};Username={databaseUsername};Password={databasePassword}");
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<PurchaseOrder>()
            .HasMany(po => po.ASNs)
            .WithOne(asn => asn.PurchaseOrder)
            .HasForeignKey(asn => asn.PurchaseOrderId);

        modelBuilder.Entity<ReceptionCreated>()
            .HasOne(x => x.Asn);

    }

    public DbSet<PurchaseOrder>? PurchaseOrders { get; set; }
    public DbSet<ASN>? ASNs { get; set; }

    public DbSet<KafkaHealthCheck>? KafkaHealthChecks { get; set; }
    public DbSet<ReceptionCreated>? KafkaReceptionCreateds { get; set; }

}