using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend.Models;

public class KafkaHealthCheckDto
{
    [Required]
    public String? Message { get; set; }
}

public class KafkaHealthCheck
{
    public KafkaHealthCheck()
    {

    }
    public KafkaHealthCheck(KafkaHealthCheckDto kafkaHealthCheckDto)
    {
        Message = kafkaHealthCheckDto.Message;
        Timestamp = DateTime.Now;
    }

    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    [Required]
    [MaxLength(256)]
    public String? Message { get; set; }

    [Required]
    [MaxLength(256)]
    public DateTime Timestamp { get; set; }
}