using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class User
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(20)]
        public string StudentId { get; set; } = string.Empty; // Mã Sinh Viên (Dùng để đăng nhập)

        [Required]
        [MaxLength(100)]
        public string FullName { get; set; } = string.Empty; // Họ và tên

        [Required]
        public string Role { get; set; } = "Member"; // Mặc định là "Member" (Sinh viên). Nếu là Lớp trưởng thì sẽ là "Admin"

        public string? PhoneNumber { get; set; } // SĐT (để Lớp trưởng tiện gọi đòi nợ quỹ lớp 😁)
    }
}