using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClassPal.Backend.Models
{
    public class ClassInfo
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string ClassName { get; set; } = string.Empty; // Ví dụ: K65-CNTT

        [StringLength(20)]
        public string? AcademicYear { get; set; } // Ví dụ: 2020-2024

        // Người quản lý lớp này (Lớp trưởng) - Là User trong hệ thống Identity
        public string? MonitorId { get; set; }
        
        [ForeignKey("MonitorId")]
        public ApplicationUser? Monitor { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
