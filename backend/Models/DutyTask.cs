using System.ComponentModel.DataAnnotations;
namespace backend.Models {
    public class DutyTask {
        [Key] public int Id { get; set; }
        [Required] public string Title { get; set; } = string.Empty;
        public string AssigneeName { get; set; } = string.Empty;
        public bool IsCompleted { get; set; } = false;
        public DateTime TaskDate { get; set; }
    }
}