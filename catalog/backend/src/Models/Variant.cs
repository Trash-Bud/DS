using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;
using System.Text.Json.Serialization;

namespace backend.Models;


public class VariantDTO
{
    public static string defaultPrePackedItem = "No";

    [Required]
    [ForeignKey("Product")]
    public int? ProductId { get; set; }

    public string? PrePackedItem { get; set; } = defaultPrePackedItem;

    [Required]
    public string? SKU { get; set; }

    [Required]
    public string? Barcode { get; set; }

    [Required]
    public string VariantDescription { get; set; } = "";

    [Required]
    public string Composition { get; set; } = "";

    [Required]
    public string? Hscode { get; set; }

    [Required]
    public string? Country { get; set; }

    public string? Gender { get; set; }

    public string? AgeGroup { get; set; }

    public string? Color { get; set; }

    public string? Size { get; set; }

    public string? Fabric { get; set; }

    [Required]
    public double? Width { get; set; }

    [Required]
    public double? Height { get; set; }

    [Required]
    public double? Depth { get; set; }

    [Required]
    public double? Weight { get; set; }

    public double? PriceRetail { get; set; }

    public double? PriceWholesale { get; set; }

    public double? Cost { get; set; }

    [Required]
    public string? Currency { get; set; }

    public int? Dangerous { get; set; }

    public int? UN { get; set; }

    public int? PackingCode { get; set; }

    public bool IsArchived { get; set; } = false;
}


public class Variant
{
    static public Variant VariantWithId(int id, VariantDTO variantDto)
    {
        Variant variant = new Variant(variantDto);
        variant.Id = id;
        return variant;
    }

    public Variant()
    {
    }

    public Variant(VariantDTO variantDTO) : base()
    {
        ProductId = variantDTO.ProductId;
        PrePackedItem = variantDTO.PrePackedItem;
        SKU = variantDTO.SKU;
        Barcode = variantDTO.Barcode;
        VariantDescription = variantDTO.VariantDescription;
        Composition = variantDTO.Composition;
        Hscode = variantDTO.Hscode;
        Country = variantDTO.Country;
        Gender = variantDTO.Gender;
        AgeGroup = variantDTO.AgeGroup;
        Color = variantDTO.Color;
        Size = variantDTO.Size;
        Fabric = variantDTO.Fabric;
        Width = variantDTO.Width;
        Height = variantDTO.Height;
        Depth = variantDTO.Depth;
        Weight = variantDTO.Weight;
        PriceRetail = variantDTO.PriceRetail;
        PriceWholesale = variantDTO.PriceWholesale;
        Cost = variantDTO.Cost;
        Currency = variantDTO.Currency;
        Dangerous = variantDTO.Dangerous;
        UN = variantDTO.UN;
        PackingCode = variantDTO.PackingCode;
        IsArchived = variantDTO.IsArchived;
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [ForeignKey("Product")]
    public int? ProductId { get; set; }

    [Required]
    [JsonIgnore]
    public Product Product { get; set; } = null!;

    public string? PrePackedItem { get; set; } = VariantDTO.defaultPrePackedItem;

    [Required]
    public string? SKU { get; set; }

    [Required]
    public string? Barcode { get; set; }

    [Required]
    public string VariantDescription { get; set; } = "";

    [Required]
    public string Composition { get; set; } = "";

    [Required]
    public string? Hscode { get; set; }

    // Iso 3166-1 Alpha 2 (iso2code)
    [Required]
    public string? Country { get; set; }

    public string? Gender { get; set; }

    public string? AgeGroup { get; set; }

    public string? Color { get; set; }

    public string? Size { get; set; }

    public string? Fabric { get; set; }

    [Required]
    public double? Width { get; set; }

    [Required]
    public double? Height { get; set; }

    [Required]
    public double? Depth { get; set; }

    [Required]
    public double? Weight { get; set; }

    public double? PriceRetail { get; set; }

    public double? PriceWholesale { get; set; }

    public double? Cost { get; set; }

    // Iso 4217 (iso3code)
    [Required]
    public string? Currency { get; set; }

    public int? Dangerous { get; set; }

    public int? UN { get; set; }

    public int? PackingCode { get; set; }

    public bool IsArchived { get; set; } = false;
}

public class IsArchivedDTO
{
    public bool IsArchived { get; set; }
}