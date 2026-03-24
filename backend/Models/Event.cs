using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class Event
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(200)]
        public string Title { get; set; } = string.Empty; // Tên sự kiện (VD: Hội thảo ABC)

        public string? Description { get; set; } // Mô tả chi tiết sự kiện

        [Required]
        public DateTime EventDate { get; set; } // Ngày giờ diễn ra

        [Required]
        [MaxLength(100)]
        public string Location { get; set; } = string.Empty; // Địa điểm (VD: Hội trường A1)

        [Required]
        public string Status { get; set; } = "MỚI"; // MỚI, ĐANG DIỄN RA, ĐÃ KẾT THÚC

        public DateTime CreatedAt { get; set; } = DateTime.Now; // Ngày tạo sự kiện
    }
}