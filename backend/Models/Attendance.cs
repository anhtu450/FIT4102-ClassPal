using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClassPal.Backend.Models
{
    public class Attendance
    {
        [Key]
        public int Id { get; set; }

        public int EventId { get; set; }
        [ForeignKey("EventId")]
        public ActivityEvent? Event { get; set; }

        public int MemberId { get; set; }
        [ForeignKey("MemberId")]
        public ClassMember? Member { get; set; }

        [Required]
        [StringLength(20)]
        public string Status { get; set; } = "Present"; // Present, Absent, Late, Excused

        [StringLength(255)]
        public string? Note { get; set; }
    }
}
