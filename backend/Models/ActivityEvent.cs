using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClassPal.Backend.Models
{
    public class ActivityEvent
    {
        [Key]
        public int Id { get; set; }

        public int ClassId { get; set; }
        [ForeignKey("ClassId")]
        public ClassInfo? ClassInfo { get; set; }

        [Required]
        [StringLength(200)]
        public string Name { get; set; } = string.Empty; // Tên sự kiện: "Lao động tập trung"

        public DateTime DateTime { get; set; }

        [StringLength(200)]
        public string? Location { get; set; }

        public string? Description { get; set; }
    }
}
