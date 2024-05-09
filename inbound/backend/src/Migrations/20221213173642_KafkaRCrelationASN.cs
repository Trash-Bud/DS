using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace backend.Migrations
{
    public partial class KafkaRCrelationASN : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ReceptionCreatedId",
                table: "ASNs",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_ASNs_ReceptionCreatedId",
                table: "ASNs",
                column: "ReceptionCreatedId");

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_KafkaReceptionCreateds_ReceptionCreatedId",
                table: "ASNs",
                column: "ReceptionCreatedId",
                principalTable: "KafkaReceptionCreateds",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_KafkaReceptionCreateds_ReceptionCreatedId",
                table: "ASNs");

            migrationBuilder.DropIndex(
                name: "IX_ASNs_ReceptionCreatedId",
                table: "ASNs");

            migrationBuilder.DropColumn(
                name: "ReceptionCreatedId",
                table: "ASNs");
        }
    }
}