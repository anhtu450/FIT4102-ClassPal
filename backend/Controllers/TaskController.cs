using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TaskController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TaskController(AppDbContext context)
        {
            _context = context;
        }

        // 1. LẤY TẤT CẢ NHIỆM VỤ (FR1.1: Để cả lớp cùng xem ai trực nhật tuần này)
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DutyTask>>> GetTasks()
        {
            return await _context.DutyTasks
                .OrderByDescending(t => t.TaskDate)
                .ToListAsync();
        }

        // 2. GIAO NHIỆM VỤ MỚI (FR1.1: Lớp trưởng tạo việc: "Trực nhật tầng 3", "Giặt giẻ lau")
        [HttpPost]
        public async Task<ActionResult<DutyTask>> CreateTask(DutyTask task)
        {
            _context.DutyTasks.Add(task);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetTasks), new { id = task.Id }, task);
        }

        // 3. XÁC NHẬN HOÀN THÀNH (FR1.3: Tổ trưởng bấm "Đã hoàn thành" để được cộng điểm)
        [HttpPut("{id}/complete")]
        public async Task<IActionResult> CompleteTask(int id)
        {
            var task = await _context.DutyTasks.FindAsync(id);
            if (task == null)
            {
                return NotFound(new { message = "Không tìm thấy nhiệm vụ này!" });
            }

            task.IsCompleted = true; // Đánh dấu đã xong
            await _context.SaveChangesAsync();

            return Ok(new { message = "Chúc mừng! Nhiệm vụ đã hoàn thành và ghi nhận vào Bảng Vàng.", task });
        }

        // 4. XÓA NHIỆM VỤ (Dành cho Lớp trưởng nếu chia nhầm tổ)
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTask(int id)
        {
            var task = await _context.DutyTasks.FindAsync(id);
            if (task == null) return NotFound();

            _context.DutyTasks.Remove(task);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}