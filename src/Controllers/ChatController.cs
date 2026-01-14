using Microsoft.AspNetCore.Mvc;
using ZavaStorefront.Services;
using ZavaStorefront.Models;

namespace ZavaStorefront.Controllers
{
    public class ChatController : Controller
    {
        private readonly ILogger<ChatController> _logger;
        private readonly FoundryService _foundryService;

        public ChatController(ILogger<ChatController> logger, FoundryService foundryService)
        {
            _logger = logger;
            _foundryService = foundryService;
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

            var response = await _foundryService.SendMessageAsync(message.Content);

            return Json(new { response = response });
        }
    }
}
