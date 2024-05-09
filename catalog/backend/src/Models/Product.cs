using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

using backend.Controllers;

using Newtonsoft.Json.Linq;

namespace backend.Models;

public class ProductDTO
{
    [Required]
    public string Name { get; set; } = "";

    public string? Description { get; set; }

    public string? Season { get; set; }

    [Required]
    public string? Supplier { get; set; }

    [Required]
    public string? Type { get; set; }

    [Required]
    public string? Family { get; set; }

    public string? SubFamily { get; set; }
}

public class Product
{
    public Product()
    {
        Variants = new List<Variant>();
    }

    public Product(ProductDTO productDTO, int brandId) : base()
    {
        SetProductProperties(productDTO, brandId);
    }

    public Product(int id, ProductDTO productDTO, int brandId)
    {
        Id = id;
        SetProductProperties(productDTO, brandId);
    }

    private void SetProductProperties(ProductDTO productDTO, int brandId)
    {
        BrandId = brandId;
        Name = productDTO.Name;
        Description = productDTO.Description;
        Season = productDTO.Season;
        Supplier = productDTO.Supplier;
        Type = productDTO.Type;
        Family = productDTO.Family;
        SubFamily = productDTO.SubFamily;
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [ForeignKey("Brand")]
    public int BrandId { get; set; }

    [Required]
    [JsonIgnore]
    public Brand Brand { get; set; } = null!;

    [Required]
    public ICollection<Variant> Variants { get; set; } = new List<Variant>();

    [Required]
    public string Name { get; set; } = "";

    public string? Description { get; set; }

    public string? Season { get; set; }

    [Required]
    public string? Supplier { get; set; }

    [Required]
    public string? Type { get; set; }

    [Required]
    public string? Family { get; set; }

    public string? SubFamily { get; set; }
}