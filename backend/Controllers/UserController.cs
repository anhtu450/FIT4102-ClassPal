using backend.Data;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserController(AppDbContext context)
        {
            _context = context;
        }

        // 1. LẤY DANH SÁCH TẤT CẢ SINH VIÊN (Dùng cho Dashboard của Lớp trưởng)
        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.Users.ToListAsync();
        }

        // 2. LẤY THÔNG TIN 1 SINH VIÊN THEO MSSV (Dùng để Đăng nhập/Check-in)
        [HttpGet("{studentId}")]
        public async Task<ActionResult<User>> GetUserByStudentId(string studentId)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.StudentId == studentId);

            if (user == null)
            {
                return NotFound(new { message = "Không tìm thấy sinh viên này!" });
            }

            return user;
        }

        // 3. THÊM SINH VIÊN MỚI (Lớp trưởng khởi tạo danh sách lớp)
        [HttpPost]
        public async Task<ActionResult<User>> PostUser(User user)
        {
            // Kiểm tra xem MSSV đã tồn tại chưa để tránh trùng lặp
            if (await _context.Users.AnyAsync(u => u.StudentId == user.StudentId))
            {
                return BadRequest(new { message = "Mã sinh viên này đã tồn tại trong hệ thống!" });
            }

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetUserByStudentId), new { studentId = user.StudentId }, user);
        }
    }
}