using System;

using Microsoft.EntityFrameworkCore.Migrations;

using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace backend.Migrations
{
    public partial class UpdateDateColumns : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "Timestamp",
                table: "KafkaHealthChecks",
                type: "timestamp with time zone USING \"Timestamp\"::timestamp with time zone",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "PurchaseOrderDate",
                table: "ASNs",
                type: "timestamp with time zone USING \"PurchaseOrderDate\"::timestamp with time zone",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "ExpectedDeliveryDate",
                table: "ASNs",
                type: "timestamp with time zone USING \"ExpectedDeliveryDate\"::timestamp with time zone",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "TEXT");

        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "PurchaseOrderDate",
                table: "ASNs",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ExpectedDeliveryDate",
                table: "ASNs",
                type: "TEXT",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "timestamp with time zone");
        }
    }
}