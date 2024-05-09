﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using backend.Models;

#nullable disable

namespace backend.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    [Migration("20221213173642_KafkaRCrelationASN")]
    partial class KafkaRCrelationASN
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("backend.Models.ASN", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Address")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("CarrierName")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<DateTime?>("ExpectedDeliveryDate")
                        .IsRequired()
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTime?>("PurchaseOrderDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int?>("PurchaseOrderId")
                        .HasColumnType("integer");

                    b.Property<int?>("ReceptionCreatedId")
                        .HasColumnType("integer");

                    b.Property<string>("ShipmentReference")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<string>("ShipperContact")
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<int>("State")
                        .HasColumnType("integer");

                    b.Property<int>("Type")
                        .HasColumnType("integer");

                    b.Property<string>("Warehouse")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.HasKey("Id");

                    b.HasIndex("PurchaseOrderId");

                    b.HasIndex("ReceptionCreatedId");

                    b.ToTable("ASNs");
                });

            modelBuilder.Entity("backend.Models.Kafka.ReceptionCreated", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<int?>("AsnId")
                        .IsRequired()
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("AsnId");

                    b.ToTable("KafkaReceptionCreateds");
                });

            modelBuilder.Entity("backend.Models.KafkaHealthCheck", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Message")
                        .IsRequired()
                        .HasMaxLength(256)
                        .HasColumnType("character varying(256)");

                    b.Property<DateTime>("Timestamp")
                        .HasMaxLength(256)
                        .HasColumnType("timestamp with time zone");

                    b.HasKey("Id");

                    b.ToTable("KafkaHealthChecks");
                });

            modelBuilder.Entity("backend.Models.Product", b =>
                {
                    b.Property<int>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("ID"));

                    b.Property<int?>("ASNId")
                        .HasColumnType("integer");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Quantity")
                        .HasColumnType("integer");

                    b.HasKey("ID");

                    b.HasIndex("ASNId");

                    b.ToTable("Product");
                });

            modelBuilder.Entity("backend.Models.PurchaseOrder", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<string>("Name")
                        .HasColumnType("text");

                    b.Property<string>("PoIdentification")
                        .HasColumnType("text");

                    b.Property<int>("ReceivedItems")
                        .HasColumnType("integer");

                    b.Property<int?>("State")
                        .HasColumnType("integer");

                    b.Property<string>("Supplier")
                        .HasColumnType("text");

                    b.Property<int?>("TotalItems")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.ToTable("PurchaseOrders");
                });

            modelBuilder.Entity("backend.Models.ASN", b =>
                {
                    b.HasOne("backend.Models.PurchaseOrder", "PurchaseOrder")
                        .WithMany("ASNs")
                        .HasForeignKey("PurchaseOrderId");

                    b.HasOne("backend.Models.Kafka.ReceptionCreated", "ReceptionCreated")
                        .WithMany()
                        .HasForeignKey("ReceptionCreatedId");

                    b.Navigation("PurchaseOrder");

                    b.Navigation("ReceptionCreated");
                });

            modelBuilder.Entity("backend.Models.Kafka.ReceptionCreated", b =>
                {
                    b.HasOne("backend.Models.ASN", "Asn")
                        .WithMany()
                        .HasForeignKey("AsnId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Asn");
                });

            modelBuilder.Entity("backend.Models.Product", b =>
                {
                    b.HasOne("backend.Models.ASN", null)
                        .WithMany("ProductList")
                        .HasForeignKey("ASNId");
                });

            modelBuilder.Entity("backend.Models.ASN", b =>
                {
                    b.Navigation("ProductList");
                });

            modelBuilder.Entity("backend.Models.PurchaseOrder", b =>
                {
                    b.Navigation("ASNs");
                });
#pragma warning restore 612, 618
        }
    }
}
