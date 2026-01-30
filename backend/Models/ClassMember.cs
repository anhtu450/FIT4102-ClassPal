using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClassPal.Backend.Models
{
    public class ClassMember
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string StudentId { get; set; } = string.Empty; // Mã sinh viên

        [Required]
        [StringLength(100)]
        public string FullName { get; set; } = string.Empty;

        public DateTime? DateOfBirth { get; set; }

        [StringLength(20)]
        public string? PhoneNumber { get; set; }

        [StringLength(50)]
        public string Position { get; set; } = "Member"; // Member, ViceMonitor, Secretary, etc.

        public int ClassId { get; set; }

        [ForeignKey("ClassId")]
        public ClassInfo? ClassInfo { get; set; }
    }
}
