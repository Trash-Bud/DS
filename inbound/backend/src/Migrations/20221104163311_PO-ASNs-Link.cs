using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class POASNsLink : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs");

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs",
                column: "PurchaseOrderId",
                principalTable: "PurchaseOrders",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs");

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs",
                column: "PurchaseOrderId",
                principalTable: "PurchaseOrders",
                principalColumn: "Id");
        }
    }
}