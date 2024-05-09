using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace backend.Models.Kafka;

public class KafkaAddress
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [JsonPropertyName("address")]
    public string? Address { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("zip")]
    public string? Zip { get; set; }

    [Required]
    [MaxLength(256)]
    [JsonPropertyName("city")]
    public string? City { get; set; }

    [Required]
    [MinLength(2)]
    [MaxLength(2)]
    [JsonPropertyName("country")]
    public string? Country { get; set; }

}