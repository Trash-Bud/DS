using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend.Models;

public class BrandDTO
{
    [Required]
    public string? Name { get; set; }
}

public class Brand
{

    public Brand()
    {
    }

    public Brand(BrandDTO brandDTO) : base()
    {
        Name = brandDTO.Name ?? "";
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }


    [Required]
    public string Name { get; set; } = "";

    [Required]
    public ICollection<Product> Products { get; set; } = new List<Product>();
}