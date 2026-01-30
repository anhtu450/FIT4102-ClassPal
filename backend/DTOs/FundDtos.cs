using System.ComponentModel.DataAnnotations;

namespace ClassPal.Backend.DTOs
{
    public class FundTransactionCreateDto
    {
        [Required]
        public int ClassId { get; set; }

        [Required]
        public string Type { get; set; } = "Income"; // Income, Expense

        [Required]
        public decimal Amount { get; set; }

        public string Description { get; set; } = string.Empty;

        public string? PerformedBy { get; set; }
    }

    public class FundTransactionViewDto
    {
        public int Id { get; set; }
        public int ClassId { get; set; }
        public string Type { get; set; } = string.Empty;
        public decimal Amount { get; set; }
        public string Description { get; set; } = string.Empty;
        public DateTime Date { get; set; }
        public string? PerformedBy { get; set; }
    }
    
    public class FundSummaryDto
    {
        public decimal TotalIncome { get; set; }
        public decimal TotalExpense { get; set; }
        public decimal CurrentBalance { get; set; }
    }
}
