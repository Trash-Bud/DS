using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace backend.Models.Kafka;

public class Item
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("reference")]
    public string? Reference { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("ean")]
    public string? Ean { get; set; }

    [Required]
    [JsonPropertyName("expected_quantity")]
    public int? ExpectedQuantity { get; set; }
}