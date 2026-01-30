using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClassPal.Backend.Models
{
    public class FundTransaction
    {
        [Key]
        public int Id { get; set; }

        public int ClassId { get; set; }
        [ForeignKey("ClassId")]
        public ClassInfo? ClassInfo { get; set; }

        [Required]
        [StringLength(10)]
        public string Type { get; set; } = "Income"; // Income (Thu), Expense (Chi)

        [Column(TypeName = "decimal(18, 2)")]
        public decimal Amount { get; set; }

        [StringLength(255)]
        public string Description { get; set; } = string.Empty; // Lý do: "Photo tài liệu", "Liên hoan"

        public DateTime Date { get; set; } = DateTime.UtcNow;

        [StringLength(100)]
        public string? PerformedBy { get; set; } // Người thực hiện (tên fill tay hoặc link user)
    }
}
