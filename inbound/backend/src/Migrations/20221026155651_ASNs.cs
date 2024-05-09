using System;

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class ASNs : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ASNs",
                columns: table => new
                {
                    Id = table.Column<int>(type: "SERIAL", nullable: false),
                    ShipmentReference = table.Column<string>(type: "TEXT", maxLength: 256, nullable: false),
                    State = table.Column<int>(type: "INTEGER", nullable: false),
                    Address = table.Column<string>(type: "TEXT", maxLength: 256, nullable: true),
                    Warehouse = table.Column<string>(type: "TEXT", maxLength: 256, nullable: false),
                    ExpectedDeliveryDate = table.Column<DateTime>(type: "TEXT", nullable: false),
                    CarrierName = table.Column<string>(type: "TEXT", maxLength: 256, nullable: true),
                    Type = table.Column<int>(type: "INTEGER", nullable: false),
                    ShipperContact = table.Column<string>(type: "TEXT", maxLength: 256, nullable: true),
                    PurchaseOrderNumber = table.Column<int>(type: "INTEGER", nullable: false),
                    PurchaseOrderDate = table.Column<DateTime>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ASNs", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Product",
                columns: table => new
                {
                    ID = table.Column<int>(type: "SERIAL", nullable: false),
                    Name = table.Column<string>(type: "TEXT", nullable: false),
                    Quantity = table.Column<int>(type: "INTEGER", nullable: false),
                    ASNId = table.Column<int>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Product", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Product_ASNs_ASNId",
                        column: x => x.ASNId,
                        principalTable: "ASNs",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Product_ASNId",
                table: "Product",
                column: "ASNId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Product");

            migrationBuilder.DropTable(
                name: "ASNs");
        }
    }
}