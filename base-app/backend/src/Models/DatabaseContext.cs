using Microsoft.EntityFrameworkCore;

namespace backend.Models;

public class DatabaseContext : DbContext
{
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.local.json", optional: true)
            .Build();
        var databaseFilePath = configuration.GetSection("DatabaseFilePath").Value ?? "./db.sqlite";
        optionsBuilder.UseSqlite(@"Data Source=" + databaseFilePath + @";foreign keys=true;");
    }

    public DbSet<ProductModel>? Products { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.Entity<ProductModel>().Property(product => product.Name)
            .IsRequired()
            .HasMaxLength(50);
        modelBuilder.Entity<ProductModel>().HasData(
            new ProductModel { Id = -1, Name = "Trainers" },
            new ProductModel { Id = -2, Name = "Shirt" });
    }
}