using System.Diagnostics.Metrics;

using Microsoft.EntityFrameworkCore;

namespace backend.Models;

public class DatabaseContext : DbContext
{
    public DatabaseContext() { }

    public DatabaseContext(DbContextOptions options) : base(options) { }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseLoggerFactory(LoggerFactory.Create(builder =>
            builder.AddFilter(_ => false)));
        if (optionsBuilder.IsConfigured) return;

        var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.local.json", optional: true)
            .Build();
        var databaseFilePath = configuration.GetSection("DatabaseFilePath").Value ?? "./db.sqlite";
        optionsBuilder.UseSqlite(@"Data Source=" + databaseFilePath + @";foreign keys=true;");
    }

    public DbSet<Product>? Products { get; set; }

    public DbSet<Variant>? Variants { get; set; }

    public DbSet<Brand>? Brands { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Product>()
            .HasMany(product => product.Variants)
            .WithOne(variant => variant.Product)
            .HasForeignKey(variant => variant.ProductId);

        modelBuilder.Entity<Brand>()
            .HasMany(brand => brand.Products)
            .WithOne(product => product.Brand)
            .HasForeignKey(product => product.BrandId);

        modelBuilder.Entity<Brand>().HasData(
            new()
            {
                Id = 1,
                Name = "Nike"
            },
            new()
            {
                Id = 2,
                Name = "Puma"
            },
            new()
            {
                Id = 3,
                Name = "Levi's"
            },
            new()
            {
                Id = 4,
                Name = "Havaianas"
            }
        );

        modelBuilder.Entity<Variant>().HasData(
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
            new()
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
        );

        modelBuilder.Entity<Product>().HasData(
            new()
            {
                Id = 1,
                BrandId = 1,
                Name = "Air Force",
                Supplier = "Nike Man.",
                Type = "Clothing",
                Family = "Shoes"
            },
            new()
            {
                Id = 2,
                BrandId = 1,
                Name = "Air Jordan 2 Low",
                Supplier = "Nike Man.",
                Type = "Clothing",
                Family = "Shoes"
            },
            new()
            {
                Id = 3,
                BrandId = 2,
                Name = "Maersk x Puma suede shoes",
                Supplier = "Puma Man.",
                Type = "Clothing",
                Family = "Shoes"
            },
            new()
            {
                Id = 4,
                BrandId = 3,
                Name = "Levi's Gold Tab Lined Worker Jacket",
                Supplier = "Levi's Man.",
                Type = "Clothing",
                Family = "Jackets"
            },
            new()
            {
                Id = 5,
                BrandId = 4,
                Name = "Havaianas Brasil Logo",
                Supplier = "Havaianas Man.",
                Type = "Clothing",
                Family = "Flip-Flops"
            }
        );
    }
}