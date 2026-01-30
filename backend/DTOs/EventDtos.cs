using System.ComponentModel.DataAnnotations;

namespace ClassPal.Backend.DTOs
{
    public class ActivityEventCreateDto
    {
        [Required]
        public int ClassId { get; set; }

        [Required]
        public string Name { get; set; } = string.Empty;

        public DateTime DateTime { get; set; }

        public string? Location { get; set; }
        public string? Description { get; set; }
    }

    public class ActivityEventViewDto
    {
        public int Id { get; set; }
        public int ClassId { get; set; }
        public string Name { get; set; } = string.Empty;
        public DateTime DateTime { get; set; }
        public string? Location { get; set; }
        public string? Description { get; set; }
    }

    public class AttendanceUpdateDto
    {
        public int MemberId { get; set; }
        
        [Required]
        public string Status { get; set; } = "Present"; // Present, Absent, ...

        public string? Note { get; set; }
    }

    public class AttendanceViewDto
    {
        public int Id { get; set; }
        public int EventId { get; set; }
        public int MemberId { get; set; }
        public string MemberName { get; set; } = string.Empty;
        public string MemberStudentId { get; set; } = string.Empty;
        public string Status { get; set; } = "Present";
        public string? Note { get; set; }
    }
}
