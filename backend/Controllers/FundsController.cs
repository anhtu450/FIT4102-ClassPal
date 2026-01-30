using ClassPal.Backend.Data;
using ClassPal.Backend.DTOs;
using ClassPal.Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClassPal.Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FundsController : ControllerBase
    {
        private readonly ClassPalDbContext _context;

        public FundsController(ClassPalDbContext context)
        {
            _context = context;
        }

        // GET: api/Funds
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FundTransactionViewDto>>> GetTransactions(int? classId)
        {
            var query = _context.FundTransactions.AsQueryable();

            if (classId.HasValue)
            {
                query = query.Where(t => t.ClassId == classId);
            }

            // Order by most recent first
            query = query.OrderByDescending(t => t.Date);

            return await query.Select(t => new FundTransactionViewDto
            {
                Id = t.Id,
                ClassId = t.ClassId,
                Type = t.Type,
                Amount = t.Amount,
                Description = t.Description,
                Date = t.Date,
                PerformedBy = t.PerformedBy
            }).ToListAsync();
        }

        // GET: api/Funds/summary
        [HttpGet("summary")]
        public async Task<ActionResult<FundSummaryDto>> GetSummary(int? classId)
        {
            var query = _context.FundTransactions.AsQueryable();

            if (classId.HasValue)
            {
                query = query.Where(t => t.ClassId == classId);
            }

            var income = await query.Where(t => t.Type == "Income").SumAsync(t => t.Amount);
            var expense = await query.Where(t => t.Type == "Expense").SumAsync(t => t.Amount);

            return new FundSummaryDto
            {
                TotalIncome = income,
                TotalExpense = expense,
                CurrentBalance = income - expense
            };
        }

        // POST: api/Funds
        [HttpPost]
        public async Task<ActionResult<FundTransactionViewDto>> PostTransaction(FundTransactionCreateDto transactionDto)
        {
            var transaction = new FundTransaction
            {
                ClassId = transactionDto.ClassId,
                Type = transactionDto.Type,
                Amount = transactionDto.Amount,
                Description = transactionDto.Description,
                PerformedBy = transactionDto.PerformedBy,
                Date = DateTime.UtcNow
            };

            _context.FundTransactions.Add(transaction);
            await _context.SaveChangesAsync();

            var transactionView = new FundTransactionViewDto
            {
                Id = transaction.Id,
                ClassId = transaction.ClassId,
                Type = transaction.Type,
                Amount = transaction.Amount,
                Description = transaction.Description,
                Date = transaction.Date,
                PerformedBy = transaction.PerformedBy
            };

            return CreatedAtAction("GetTransactions", new { id = transaction.Id }, transactionView);
        }
        
        // DELETE: api/Funds/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTransaction(int id)
        {
            var transaction = await _context.FundTransactions.FindAsync(id);
            if (transaction == null)
            {
                return NotFound();
            }

            _context.FundTransactions.Remove(transaction);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
