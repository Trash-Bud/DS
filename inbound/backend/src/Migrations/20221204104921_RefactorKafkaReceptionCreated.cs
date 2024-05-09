using System;

using Microsoft.EntityFrameworkCore.Migrations;

using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace backend.Migrations
{
    public partial class RefactorKafkaReceptionCreated : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KafkaReceptionCreateds_KafkaPurchaseOrders_PurchaseOrderId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropForeignKey(
                name: "FK_KafkaReceptionCreateds_KafkaReceptions_ReceptionId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropTable(
                name: "KafkaPurchaseOrders");

            migrationBuilder.DropTable(
                name: "KafkaReceptionsItems");

            migrationBuilder.DropTable(
                name: "Suppliers");

            migrationBuilder.DropTable(
                name: "KafkaReceptions");

            migrationBuilder.DropTable(
                name: "KafkaAddresses");

            migrationBuilder.DropIndex(
                name: "IX_KafkaReceptionCreateds_PurchaseOrderId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropIndex(
                name: "IX_KafkaReceptionCreateds_ReceptionId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropColumn(
                name: "PurchaseOrderId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropColumn(
                name: "ReceptionCreatedId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropColumn(
                name: "ReceptionId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.RenameColumn(
                name: "Timestamp",
                table: "KafkaReceptionCreateds",
                newName: "AsnId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionCreateds_AsnId",
                table: "KafkaReceptionCreateds",
                column: "AsnId");

            migrationBuilder.AddForeignKey(
                name: "FK_KafkaReceptionCreateds_ASNs_AsnId",
                table: "KafkaReceptionCreateds",
                column: "AsnId",
                principalTable: "ASNs",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KafkaReceptionCreateds_ASNs_AsnId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.DropIndex(
                name: "IX_KafkaReceptionCreateds_AsnId",
                table: "KafkaReceptionCreateds");

            migrationBuilder.RenameColumn(
                name: "AsnId",
                table: "KafkaReceptionCreateds",
                newName: "Timestamp");

            migrationBuilder.AddColumn<int>(
                name: "PurchaseOrderId",
                table: "KafkaReceptionCreateds",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "ReceptionCreatedId",
                table: "KafkaReceptionCreateds",
                type: "character varying(256)",
                maxLength: 256,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "ReceptionId",
                table: "KafkaReceptionCreateds",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "KafkaAddresses",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Address = table.Column<string>(type: "text", nullable: false),
                    City = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    Country = table.Column<string>(type: "character varying(2)", maxLength: 2, nullable: false),
                    Zip = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false)
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
                    Number = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    PlannedDeliveryDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Reference = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
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
                    AddressId = table.Column<int>(type: "integer", nullable: false),
                    ContactPerson = table.Column<string>(type: "text", nullable: true),
                    Email = table.Column<string>(type: "text", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Phone = table.Column<string>(type: "text", nullable: false),
                    TaxNumber = table.Column<string>(type: "text", nullable: false)
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
                    Ean = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    ExpectedQuantity = table.Column<int>(type: "integer", nullable: false),
                    ReceptionId = table.Column<int>(type: "integer", nullable: true),
                    Reference = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false)
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
                    SupplierId = table.Column<int>(type: "integer", nullable: false),
                    BrandId = table.Column<int>(type: "integer", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Reference = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false)
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

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionCreateds_PurchaseOrderId",
                table: "KafkaReceptionCreateds",
                column: "PurchaseOrderId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionCreateds_ReceptionId",
                table: "KafkaReceptionCreateds",
                column: "ReceptionId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaPurchaseOrders_SupplierId",
                table: "KafkaPurchaseOrders",
                column: "SupplierId");

            migrationBuilder.CreateIndex(
                name: "IX_KafkaReceptionsItems_ReceptionId",
                table: "KafkaReceptionsItems",
                column: "ReceptionId");

            migrationBuilder.CreateIndex(
                name: "IX_Suppliers_AddressId",
                table: "Suppliers",
                column: "AddressId");

            migrationBuilder.AddForeignKey(
                name: "FK_KafkaReceptionCreateds_KafkaPurchaseOrders_PurchaseOrderId",
                table: "KafkaReceptionCreateds",
                column: "PurchaseOrderId",
                principalTable: "KafkaPurchaseOrders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_KafkaReceptionCreateds_KafkaReceptions_ReceptionId",
                table: "KafkaReceptionCreateds",
                column: "ReceptionId",
                principalTable: "KafkaReceptions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}