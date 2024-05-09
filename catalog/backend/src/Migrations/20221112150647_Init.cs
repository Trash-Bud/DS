using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class Init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Brands",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Name = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Brands", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    BrandId = table.Column<int>(type: "INTEGER", nullable: false),
                    Name = table.Column<string>(type: "TEXT", nullable: false),
                    Description = table.Column<string>(type: "TEXT", nullable: true),
                    Season = table.Column<string>(type: "TEXT", nullable: true),
                    Supplier = table.Column<string>(type: "TEXT", nullable: false),
                    Type = table.Column<string>(type: "TEXT", nullable: false),
                    Family = table.Column<string>(type: "TEXT", nullable: false),
                    SubFamily = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Products_Brands_BrandId",
                        column: x => x.BrandId,
                        principalTable: "Brands",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Variants",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    ProductId = table.Column<int>(type: "INTEGER", nullable: false),
                    PrePackedItem = table.Column<string>(type: "TEXT", nullable: true),
                    SKU = table.Column<string>(type: "TEXT", nullable: false),
                    Barcode = table.Column<string>(type: "TEXT", nullable: false),
                    VariantDescription = table.Column<string>(type: "TEXT", nullable: false),
                    Composition = table.Column<string>(type: "TEXT", nullable: false),
                    Hscode = table.Column<string>(type: "TEXT", nullable: false),
                    Country = table.Column<string>(type: "TEXT", nullable: false),
                    Gender = table.Column<string>(type: "TEXT", nullable: true),
                    AgeGroup = table.Column<string>(type: "TEXT", nullable: true),
                    Color = table.Column<string>(type: "TEXT", nullable: true),
                    Size = table.Column<string>(type: "TEXT", nullable: true),
                    Fabric = table.Column<string>(type: "TEXT", nullable: true),
                    Width = table.Column<double>(type: "REAL", nullable: false),
                    Height = table.Column<double>(type: "REAL", nullable: false),
                    Depth = table.Column<double>(type: "REAL", nullable: false),
                    Weight = table.Column<double>(type: "REAL", nullable: false),
                    PriceRetail = table.Column<double>(type: "REAL", nullable: true),
                    PriceWholesale = table.Column<double>(type: "REAL", nullable: true),
                    Cost = table.Column<double>(type: "REAL", nullable: true),
                    Currency = table.Column<string>(type: "TEXT", nullable: false),
                    Dangerous = table.Column<int>(type: "INTEGER", nullable: true),
                    UN = table.Column<int>(type: "INTEGER", nullable: true),
                    PackingCode = table.Column<int>(type: "INTEGER", nullable: true),
                    IsArchived = table.Column<bool>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Variants", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Variants_Products_ProductId",
                        column: x => x.ProductId,
                        principalTable: "Products",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Brands",
                columns: new[] { "Id", "Name" },
                values: new object[] { 1, "Nike" });

            migrationBuilder.InsertData(
                table: "Brands",
                columns: new[] { "Id", "Name" },
                values: new object[] { 2, "Puma" });

            migrationBuilder.InsertData(
                table: "Brands",
                columns: new[] { "Id", "Name" },
                values: new object[] { 3, "Levi's" });

            migrationBuilder.InsertData(
                table: "Brands",
                columns: new[] { "Id", "Name" },
                values: new object[] { 4, "Havaianas" });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "BrandId", "Description", "Family", "Name", "Season", "SubFamily", "Supplier", "Type" },
                values: new object[] { 1, 1, null, "Shoes", "Air Force", null, null, "Nike Man.", "Clothing" });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "BrandId", "Description", "Family", "Name", "Season", "SubFamily", "Supplier", "Type" },
                values: new object[] { 2, 1, null, "Shoes", "Air Jordan 2 Low", null, null, "Nike Man.", "Clothing" });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "BrandId", "Description", "Family", "Name", "Season", "SubFamily", "Supplier", "Type" },
                values: new object[] { 3, 2, null, "Shoes", "Maersk x Puma suede shoes", null, null, "Puma Man.", "Clothing" });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "BrandId", "Description", "Family", "Name", "Season", "SubFamily", "Supplier", "Type" },
                values: new object[] { 4, 3, null, "Jackets", "Levi's Gold Tab Lined Worker Jacket", null, null, "Levi's Man.", "Clothing" });

            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "Id", "BrandId", "Description", "Family", "Name", "Season", "SubFamily", "Supplier", "Type" },
                values: new object[] { 5, 4, null, "Flip-Flops", "Havaianas Brasil Logo", null, null, "Havaianas Man.", "Clothing" });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 1, null, "5714326008476", null, "100% Leather", null, "US", "USD", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "White version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 2, null, "5214426038376", null, "100% Leather", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "Brown version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 3, null, "5234426937376", null, "10% Cotton, 90% Polyamide", null, "US", "USD", null, 27.0, null, null, 4.0, "64031900", false, null, "No", null, null, 3, "DV7119-222", null, null, "Blue version", 0.59999999999999998, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 4, null, "5947420582976", null, "100% Cotton", null, "FR", "EUR", null, 1.0, null, null, 10.0, "64031900", false, null, "No", null, null, 4, "DV4519-222", null, null, "Blue version", 0.59999999999999998, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 5, null, "1237493750276", null, "100% Rubber", null, "BZ", "BRL", null, 1.0, null, null, 20.0, "34631920", false, null, "No", null, null, 5, "DV4519-222", null, null, "Green version", 0.59999999999999998, 5.0 });

            migrationBuilder.CreateIndex(
                name: "IX_Products_BrandId",
                table: "Products",
                column: "BrandId");

            migrationBuilder.CreateIndex(
                name: "IX_Variants_ProductId",
                table: "Variants",
                column: "ProductId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Variants");

            migrationBuilder.DropTable(
                name: "Products");

            migrationBuilder.DropTable(
                name: "Brands");
        }
    }
}