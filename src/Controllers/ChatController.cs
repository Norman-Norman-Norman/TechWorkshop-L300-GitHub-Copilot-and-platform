using Microsoft.AspNetCore.Mvc;
using ZavaStorefront.Services;
using ZavaStorefront.Models;

namespace ZavaStorefront.Controllers
{
    public class ChatController : Controller
    {
        private readonly ILogger<ChatController> _logger;
        private readonly FoundryService _foundryService;
        private readonly ContentSafetyService _contentSafetyService;

        public ChatController(
            ILogger<ChatController> logger, 
            FoundryService foundryService,
            ContentSafetyService contentSafetyService)
        {
            _logger = logger;
            _foundryService = foundryService;
            _contentSafetyService = contentSafetyService;
        }

        public IActionResult Index()
        {
            _logger.LogInformation("Chat page accessed");
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SendMessage([FromBody] ChatMessage message)
        {
            if (string.IsNullOrWhiteSpace(message.Content))
            {
                return BadRequest(new { error = "Message content cannot be empty" });
            }

            _logger.LogInformation("Processing chat message: {Message}", message.Content);

            // Task 06.03: Content Safety Check - evaluate user message before sending to AI
            var safetyResult = await _contentSafetyService.EvaluateContentAsync(message.Content);
            
            if (!safetyResult.IsSafe)
            {
                _logger.LogWarning("ContentSafety: Message blocked - Category={Category}, Severity={Severity}", 
                    safetyResult.BlockedCategory, safetyResult.Severity);
                
                return Json(new { 
                    response = safetyResult.Message,
                    blocked = true,
                    category = safetyResult.BlockedCategory,
                    severity = safetyResult.Severity
                });
            }

            // Content is safe - proceed to AI model
            var response = await _foundryService.SendMessageAsync(message.Content);

            return Json(new { response = response });
        }
    }
}
