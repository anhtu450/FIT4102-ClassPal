using System.ComponentModel.DataAnnotations;

namespace ClassPal.Backend.DTOs
{
    public class MemberCreateDto
    {
        [Required]
        public string FullName { get; set; } = string.Empty;
        
        [Required]
        public string StudentId { get; set; } = string.Empty;

        public DateTime? DateOfBirth { get; set; }
        public string? PhoneNumber { get; set; }
        public string Position { get; set; } = "Member";
        
        [Required]
        public int ClassId { get; set; }
    }

    public class MemberUpdateDto
    {
        public string FullName { get; set; } = string.Empty;
        public string StudentId { get; set; } = string.Empty;
        public DateTime? DateOfBirth { get; set; }
        public string? PhoneNumber { get; set; }
        public string Position { get; set; } = "Member";
    }

    public class MemberViewDto
    {
        public int Id { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string StudentId { get; set; } = string.Empty;
        public DateTime? DateOfBirth { get; set; }
        public string? PhoneNumber { get; set; }
        public string Position { get; set; } = "Member";
        public int ClassId { get; set; }
    }
}
