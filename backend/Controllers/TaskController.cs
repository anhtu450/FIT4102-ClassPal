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

        // 1. Lấy danh sách toàn bộ nhiệm vụ (Để hiển thị lên App)
        // GET: api/task
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DutyTask>>> GetTasks()
        {
            return await _context.DutyTasks.ToListAsync();
        }

        // 2. Tạo nhiệm vụ mới (Lớp trưởng thêm lịch trực nhật)
        // POST: api/task
        [HttpPost]
        public async Task<ActionResult<DutyTask>> CreateTask(DutyTask task)
        {
            _context.DutyTasks.Add(task);
            await _context.SaveChangesAsync();

            // Trả về mã 201 Created và dữ liệu vừa tạo
            return CreatedAtAction(nameof(GetTasks), new { id = task.Id }, task);
        }

        // 3. Cập nhật trạng thái "Hoàn thành" (Nút gạt toggle trên UI)
        // PUT: api/task/5/toggle
        [HttpPut("{id}/toggle")]
        public async Task<IActionResult> ToggleTaskCompletion(int id)
        {
            var task = await _context.DutyTasks.FindAsync(id);
            if (task == null)
            {
                return NotFound("Không tìm thấy nhiệm vụ!");
            }

            // Đảo ngược trạng thái (đang false thành true, đang true thành false)
            task.IsCompleted = !task.IsCompleted; 
            await _context.SaveChangesAsync();

            return Ok(task);
        }

        // 4. Xóa nhiệm vụ
        // DELETE: api/task/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTask(int id)
        {
            var task = await _context.DutyTasks.FindAsync(id);
            if (task == null)
            {
                return NotFound();
            }

            _context.DutyTasks.Remove(task);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}