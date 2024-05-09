using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class LinkPOASN : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "PurchaseOrderNumber",
                table: "ASNs",
                newName: "PurchaseOrderId");

            migrationBuilder.CreateIndex(
                name: "IX_ASNs_PurchaseOrderId",
                table: "ASNs",
                column: "PurchaseOrderId");

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs",
                column: "PurchaseOrderId",
                principalTable: "PurchaseOrders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs");

            migrationBuilder.DropIndex(
                name: "IX_ASNs_PurchaseOrderId",
                table: "ASNs");

            migrationBuilder.RenameColumn(
                name: "PurchaseOrderId",
                table: "ASNs",
                newName: "PurchaseOrderNumber");
        }
    }
}