using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace backend.Models.Kafka;

public class KafkaPurchaseOrder
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("reference")]
    public string? Reference { get; set; }

    [Required]
    [JsonPropertyName("date")]
    public DateTime? Date { get; set; }

    [Required]
    [JsonPropertyName("brand_id")]
    public int? BrandId { get; set; }

    [Required]
    [JsonPropertyName("supplier")]
    public Supplier? Supplier { get; set; } = null!;
}