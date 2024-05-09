using backend.Kafka;
using backend.Models;
using backend.Models.Kafka;

using FluentValidation;
using FluentValidation.Results;

using kafka;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;

using Newtonsoft.Json;

namespace backend.Controllers;

[ApiController]
[Route("/kafka")]
public class KafkaController : ControllerBase
{
    private readonly DatabaseContext _context;

    private readonly KafkaConfig _kafkaConfig;
    private readonly ILogger<KafkaController> _logger;
    private readonly DbSet<KafkaHealthCheck> _dbSetKafkaHealthCheck;

    private readonly DbSet<ReceptionCreated> _dbSetKafkaReceptionCreated;
    private readonly DbSet<ReceptionReceived> _dbSetKafkaReceptionReceived;

    public KafkaController(DatabaseContext context, ILogger<KafkaController> logger)
    {
        this._context = context;
        this._dbSetKafkaHealthCheck = this._context.Set<KafkaHealthCheck>();
        this._dbSetKafkaReceptionCreated = this._context.Set<ReceptionCreated>();
        this._dbSetKafkaReceptionReceived = this._context.Set<ReceptionReceived>();
        this._kafkaConfig = new KafkaConfig();
        this._logger = logger;
    }

    [HttpPost("health", Name = "HealthCheck")]
    public ActionResult<String> Create(KafkaHealthCheckDto kafkaHealthCheckDto)
    {
        KafkaHealthCheck kafkaHealthCheck = new(kafkaHealthCheckDto);
        Producer<KafkaHealthCheck> producer = new(_kafkaConfig.Prefix + TopicsNames.HealthCheck, this._kafkaConfig);

        try
        {
            producer.Send(kafkaHealthCheck);
        }
        catch (Exception e)
        {
            _logger.LogError(e.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, "Error connecting to kafka system");
        }

        return Ok("Sent");
    }

    [HttpGet("health", Name = "HealthCheck")]
    public List<KafkaHealthCheck> GetAll()
    {
        return _dbSetKafkaHealthCheck.ToList();
    }

    [HttpGet("receptions-created", Name = "GetReceptionCreated")]
    public ActionResult<List<ReceptionCreated>> GetReceptionsCreated()
    {
        return Ok(_dbSetKafkaReceptionCreated
            .Include(x => x.Asn)
            .Include(x => x.Asn!.ProductList)
            .Include(x => x.Asn!.PurchaseOrder)
            .ToList());
    }

    [HttpPost("reception-created/{asnId}", Name = "SendReceptionCreated")]
    public IActionResult Send(int asnId, [FromServices] IValidator<ReceptionCreated> validator)
    {
        ReceptionCreated receptionCreated = new ReceptionCreated(asnId);

        ValidationResult validationResult = validator.Validate(receptionCreated);
        if (!validationResult.IsValid)
        {
            var modelStateDict = new ModelStateDictionary();
            foreach (ValidationFailure fail in validationResult.Errors)
            {
                modelStateDict.AddModelError(fail.PropertyName, fail.ErrorMessage);
            }

            return ValidationProblem(modelStateDict);
        }

        Producer<ReceptionCreated> producer = new(_kafkaConfig.Prefix + TopicsNames.ReceptionCreated, this._kafkaConfig);
        try
        {
            producer.Send(receptionCreated);
        }
        catch (Exception e)
        {
            _logger.LogError(e.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, "Error connecting to kafka system");
        }

        return Ok();
    }


    [HttpGet("receptions-received", Name = "GetReceptionReceived")]
    public ActionResult<List<ReceptionReceived>> GetReceptionsReceived()
    {
        return Ok(_dbSetKafkaReceptionReceived
            .Include(x => x.Asn)
            .Include(x => x.Asn!.ProductList)
            .Include(x => x.Asn!.PurchaseOrder)
            .ToList());
    }

    [HttpPost("reception-received/{asnId}", Name = "SendReceptionReceived")]
    public IActionResult Send(int asnId, [FromServices] IValidator<ReceptionReceived> validator)
    {
        ReceptionReceived receptionReceived = new ReceptionReceived(asnId);

        ValidationResult validationResult = validator.Validate(receptionReceived);
        if (!validationResult.IsValid)
        {
            var modelStateDict = new ModelStateDictionary();
            foreach (ValidationFailure fail in validationResult.Errors)
            {
                modelStateDict.AddModelError(fail.PropertyName, fail.ErrorMessage);
            }

            return ValidationProblem(modelStateDict);
        }

        Producer<ReceptionReceived> producer = new(_kafkaConfig.Prefix + TopicsNames.ReceptionReceived, this._kafkaConfig);
        try
        {
            producer.Send(receptionReceived);
        }
        catch (Exception e)
        {
            _logger.LogError(e.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, "Error connecting to kafka system");
        }

        return Ok();
    }

}