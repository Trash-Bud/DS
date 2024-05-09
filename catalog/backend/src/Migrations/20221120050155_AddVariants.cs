using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class AddVariants : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "Barcode", "Country", "Currency", "Depth", "Height", "ProductId", "SKU", "VariantDescription", "Weight", "Width" },
                values: new object[] { "5714326008477", "US", "USD", 25.0, 6.0, 1, "tra/nik/whi/lea", "Black version", 0.73999999999999999, 5.0 });

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "Barcode", "Composition", "Depth", "Height", "ProductId", "SKU", "VariantDescription", "Weight", "Width" },
                values: new object[] { "5714326008478", "100% Leather", 25.0, 6.0, 1, "tra/nik/whi/lea", "Brown version", 0.73999999999999999, 5.0 });

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "Barcode", "Composition", "Country", "Depth", "Height", "ProductId", "SKU", "VariantDescription", "Weight" },
                values: new object[] { "5714326008476", "100% Leather", "PT", 25.0, 6.0, 1, "tra/nik/whi/lea", "White version", 0.73999999999999999 });

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "Barcode", "Composition", "Country", "Currency", "Depth", "Height", "Hscode", "ProductId", "SKU", "VariantDescription", "Weight" },
                values: new object[] { "5714326008477", "100% Leather", "PT", "EUR", 25.0, 6.0, "64031900", 1, "tra/nik/whi/lea", "Black version", 0.73999999999999999 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 6, null, "5714326008478", null, "100% Leather", null, "PT", "EUR", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "Brown version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 7, null, "5214426038376", null, "100% Leather", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "White version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 8, null, "5214426038376", null, "100% Leather", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "Black version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 9, null, "5214426038376", null, "100% Leather", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "Brown version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 10, null, "5214426038376", null, "50% Leather, 50% Cotton", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "White version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 11, null, "5214426038376", null, "50% Leather, 50% Cotton", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "Black version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 12, null, "5214426038376", null, "50% Leather, 50% Cotton", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "Brown version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 13, null, "5234426937376", null, "10% Cotton, 90% Polyamide", null, "US", "USD", null, 27.0, null, null, 4.0, "64031900", false, null, "No", null, null, 3, "DV7119-222", null, null, "Blue version", 0.59999999999999998, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 14, null, "5947420582976", null, "100% Cotton", null, "FR", "EUR", null, 1.0, null, null, 10.0, "64031900", false, null, "No", null, null, 4, "DV4519-222", null, null, "Blue version", 0.59999999999999998, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 15, null, "1237493750276", null, "100% Rubber", null, "BZ", "BRL", null, 1.0, null, null, 20.0, "34631920", false, null, "No", null, null, 5, "DV4519-222", null, null, "Green version", 0.59999999999999998, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 16, null, "5714326008476", null, "100% Pain", null, "US", "USD", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "DS version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 17, null, "5714326008477", null, "100% Pain", null, "US", "USD", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "DS version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 18, null, "5714326008478", null, "100% Pain", null, "US", "USD", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "DS version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 19, null, "5714326008476", null, "100% Pain", null, "PT", "EUR", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "DS version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 20, null, "5714326008477", null, "100% Pain", null, "PT", "EUR", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "DS version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 21, null, "5714326008478", null, "100% Pain", null, "PT", "EUR", null, 25.0, null, null, 6.0, "64031900", false, null, "No", null, null, 1, "tra/nik/whi/lea", null, null, "DS version", 0.73999999999999999, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 22, null, "5214426038376", null, "100% Pain", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "DS version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 23, null, "5214426038376", null, "100% Pain", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "DS version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 24, null, "5214426038376", null, "100% Pain", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "DS version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 25, null, "5214426038376", null, "100% Pain", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "DS version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 26, null, "5214426038376", null, "100% Pain", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "DS version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 27, null, "5214426038376", null, "100% Pain", null, "PT", "EUR", null, 30.0, null, null, 5.0, "64031900", false, null, "No", null, null, 2, "DV7129-222", null, null, "DS version", 0.80000000000000004, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 28, null, "5234426937376", null, "100% Pain", null, "US", "USD", null, 27.0, null, null, 4.0, "64031900", false, null, "No", null, null, 3, "DV7119-222", null, null, "DS version", 0.59999999999999998, 4.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 29, null, "5947420582976", null, "100% Pain", null, "FR", "EUR", null, 1.0, null, null, 10.0, "64031900", false, null, "No", null, null, 4, "DV4519-222", null, null, "DS version", 0.59999999999999998, 5.0 });

            migrationBuilder.InsertData(
                table: "Variants",
                columns: new[] { "Id", "AgeGroup", "Barcode", "Color", "Composition", "Cost", "Country", "Currency", "Dangerous", "Depth", "Fabric", "Gender", "Height", "Hscode", "IsArchived", "PackingCode", "PrePackedItem", "PriceRetail", "PriceWholesale", "ProductId", "SKU", "Size", "UN", "VariantDescription", "Weight", "Width" },
                values: new object[] { 30, null, "1237493750276", null, "100% Pain", null, "BZ", "BRL", null, 1.0, null, null, 20.0, "34631920", false, null, "No", null, null, 5, "DV4519-222", null, null, "DS version", 0.59999999999999998, 5.0 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "Barcode", "Country", "Currency", "Depth", "Height", "ProductId", "SKU", "VariantDescription", "Weight", "Width" },
                values: new object[] { "5214426038376", "PT", "EUR", 30.0, 5.0, 2, "DV7129-222", "Brown version", 0.80000000000000004, 4.0 });

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "Barcode", "Composition", "Depth", "Height", "ProductId", "SKU", "VariantDescription", "Weight", "Width" },
                values: new object[] { "5234426937376", "10% Cotton, 90% Polyamide", 27.0, 4.0, 3, "DV7119-222", "Blue version", 0.59999999999999998, 4.0 });

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "Barcode", "Composition", "Country", "Depth", "Height", "ProductId", "SKU", "VariantDescription", "Weight" },
                values: new object[] { "5947420582976", "100% Cotton", "FR", 1.0, 10.0, 4, "DV4519-222", "Blue version", 0.59999999999999998 });

            migrationBuilder.UpdateData(
                table: "Variants",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "Barcode", "Composition", "Country", "Currency", "Depth", "Height", "Hscode", "ProductId", "SKU", "VariantDescription", "Weight" },
                values: new object[] { "1237493750276", "100% Rubber", "BZ", "BRL", 1.0, 20.0, "34631920", 5, "DV4519-222", "Green version", 0.59999999999999998 });
        }
    }
}