using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventController(AppDbContext context) : ControllerBase
    {
        private readonly AppDbContext _context = context;

        // 1. LẤY DANH SÁCH SỰ KIỆN (FR3.1: Sinh viên xem để biết sắp có hội thảo gì)
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Event>>> GetEvents()
        {
            return await _context.Events
                .OrderBy(e => e.EventDate)
                .ToListAsync();
        }

        // 2. TẠO SỰ KIỆN MỚI (FR3.1: Lớp trưởng tạo "Hội thảo ABC", "Học bù")
        [HttpPost]
        public async Task<ActionResult<Event>> CreateEvent(Event ev)
        {
            _context.Events.Add(ev);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetEvents), new { id = ev.Id }, ev);
        }

        // 3. CẬP NHẬT TRẠNG THÁI (FR3.1: Chuyển từ "MỚI" sang "ĐÃ KẾT THÚC")
        [HttpPut("{id}/status")]
        public async Task<IActionResult> UpdateStatus(int id, [FromBody] string status)
        {
            var ev = await _context.Events.FindAsync(id);
            if (ev == null) return NotFound();

            ev.Status = status;
            await _context.SaveChangesAsync();
            return Ok(ev);
        }
    }
}