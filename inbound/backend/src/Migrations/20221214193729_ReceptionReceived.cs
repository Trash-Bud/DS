using Microsoft.EntityFrameworkCore.Migrations;

using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace backend.Migrations
{
    public partial class ReceptionReceived : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ReceptionReceivedId",
                table: "ASNs",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ReceptionReceived",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    AsnId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ReceptionReceived", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ReceptionReceived_ASNs_AsnId",
                        column: x => x.AsnId,
                        principalTable: "ASNs",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ASNs_ReceptionReceivedId",
                table: "ASNs",
                column: "ReceptionReceivedId");

            migrationBuilder.CreateIndex(
                name: "IX_ReceptionReceived_AsnId",
                table: "ReceptionReceived",
                column: "AsnId");

            migrationBuilder.AddForeignKey(
                name: "FK_ASNs_ReceptionReceived_ReceptionReceivedId",
                table: "ASNs",
                column: "ReceptionReceivedId",
                principalTable: "ReceptionReceived",
                principalColumn: "Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ASNs_ReceptionReceived_ReceptionReceivedId",
                table: "ASNs");

            migrationBuilder.DropTable(
                name: "ReceptionReceived");

            migrationBuilder.DropIndex(
                name: "IX_ASNs_ReceptionReceivedId",
                table: "ASNs");

            migrationBuilder.DropColumn(
                name: "ReceptionReceivedId",
                table: "ASNs");
        }
    }
}