using Microsoft.AspNetCore.Identity;

namespace ClassPal.Backend.Models
{
    public class ApplicationUser : IdentityUser
    {
        public string FullName { get; set; } = string.Empty;
        public string? StudentId { get; set; } // Mã sinh viên (Nullable vì Admin có thể không có)
        public string? ClassName { get; set; } // Lớp (ví dụ: K65-CNTT)
    }
}
