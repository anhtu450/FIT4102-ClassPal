using System;
using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class DutyTask
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(100)]
        public string Title { get; set; } // Ví dụ: "Ca sáng, 07:00 - 12:00"

        [MaxLength(255)]
        public string Description { get; set; } // Ví dụ: "Kiểm tra hệ thống, báo cáo sự cố"

        [Required]
        public string AssigneeName { get; set; } // Tên người được phân công (Nguyễn Văn A)

        public bool IsCompleted { get; set; } = false; // Trạng thái Hoàn thành (nút gạt)

        public DateTime TaskDate { get; set; } // Ngày thực hiện nhiệm vụ
    }
}