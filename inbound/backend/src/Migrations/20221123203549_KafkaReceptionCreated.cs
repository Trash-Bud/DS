using System;

using Microsoft.EntityFrameworkCore.Migrations;

using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace backend.Migrations
{
    public partial class KafkaReceptionCreated : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "KafkaAddresses",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Address = table.Column<string>(type: "text", nullable: false),
                    Zip = table.Column<string>(type: "text", nullable: false),
                    City = table.Column<string>(type: "text", nullable: false),
                    Country = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KafkaAddresses", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "KafkaReceptions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Reference = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    Number = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    PlannedDeliveryDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    WarehouseCode = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KafkaReceptions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Suppliers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Email = table.Column<string>(type: "text", nullable: false),
                    Phone = table.Column<string>(type: "text", nullable: false),
                    ContactPerson = table.Column<string>(type: "text", nullable: false),
                    TaxNumber = table.Column<string>(type: "text", nullable: false),
                    AddressId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Suppliers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Suppliers_KafkaAddresses_AddressId",
                        column: x => x.AddressId,
                        principalTable: "KafkaAddresses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KafkaReceptionsItems",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Reference = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    Ean = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    ExpectedQuantity = table.Column<int>(type: "integer", nullable: false),
                    ReceptionId = table.Column<int>(type: "integer", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KafkaReceptionsItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KafkaReceptionsItems_KafkaReceptions_ReceptionId",
                        column: x => x.ReceptionId,
                        principalTable: "KafkaReceptions",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "KafkaPurchaseOrders",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Reference = table.Column<string>(type: "text", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    BrandId = table.Column<int>(type: "integer", nullable: false),
                    SupplierId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KafkaPurchaseOrders", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KafkaPurchaseOrders_Suppliers_SupplierId",
                        column: x => x.SupplierId,
                        principalTable: "Suppliers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KafkaReceptionCreateds",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ReceptionCreatedId = table.Column<string>(type: "text", nullable: false),
                    Timestamp = table.Column<int>(type: "integer", nullable: false),
                    ReceptionId = table.Column<int>(type: "integer", nullable: false),
                    PurchaseOrderId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KafkaReceptionCreateds", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KafkaReceptionCreateds_KafkaPurchaseOrders_PurchaseOrderId",
                        column: x => x.PurchaseOrderId,
                        principalTable: "KafkaPurchaseOrders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KafkaReceptionCreateds_KafkaReceptions_ReceptionId",
                        column: x => x.ReceptionId,
                        principalTable: "KafkaReceptions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_KafkaPurchaseOrders_SupplierId",
                table: "KafkaPurchaseOrders",
                column: "SupplierId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionCreateds_PurchaseOrderId",
                table: "KafkaReceptionCreateds",
                column: "PurchaseOrderId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionCreateds_ReceptionId",
                table: "KafkaReceptionCreateds",
                column: "ReceptionId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionsItems_ReceptionId",
                table: "KafkaReceptionsItems",
                column: "ReceptionId");

            migrationBuilder.CreateIndex(
                name: "IX_Suppliers_AddressId",
                table: "Suppliers",
                column: "AddressId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KafkaReceptionCreateds");

            migrationBuilder.DropTable(
                name: "KafkaReceptionsItems");

            migrationBuilder.DropTable(
                name: "KafkaPurchaseOrders");

            migrationBuilder.DropTable(
                name: "KafkaReceptions");

            migrationBuilder.DropTable(
                name: "Suppliers");

            migrationBuilder.DropTable(
                name: "KafkaAddresses");
        }
    }
}