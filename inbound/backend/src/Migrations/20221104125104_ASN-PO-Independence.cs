using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class ASNPOIndependence : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs");

            migrationBuilder.AlterColumn<int>(
                name: "PurchaseOrderId",
                table: "ASNs",
                type: "INTEGER",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs",
                column: "PurchaseOrderId",
                principalTable: "PurchaseOrders",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs");

            migrationBuilder.AlterColumn<int>(
                name: "PurchaseOrderId",
                table: "ASNs",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "INTEGER",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_PurchaseOrders_PurchaseOrderId",
                table: "ASNs",
                column: "PurchaseOrderId",
                principalTable: "PurchaseOrders",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}