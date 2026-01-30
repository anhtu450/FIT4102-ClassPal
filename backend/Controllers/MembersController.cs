using ClassPal.Backend.Data;
using ClassPal.Backend.DTOs;
using ClassPal.Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClassPal.Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MembersController : ControllerBase
    {
        private readonly ClassPalDbContext _context;

        public MembersController(ClassPalDbContext context)
        {
            _context = context;
        }

        // GET: api/Members
        [HttpGet]
        public async Task<ActionResult<IEnumerable<MemberViewDto>>> GetMembers(int? classId)
        {
            var query = _context.ClassMembers.AsQueryable();

            if (classId.HasValue)
            {
                query = query.Where(m => m.ClassId == classId);
            }

            return await query.Select(m => new MemberViewDto
            {
                Id = m.Id,
                FullName = m.FullName,
                StudentId = m.StudentId,
                DateOfBirth = m.DateOfBirth,
                PhoneNumber = m.PhoneNumber,
                Position = m.Position,
                ClassId = m.ClassId
            }).ToListAsync();
        }

        // GET: api/Members/5
        [HttpGet("{id}")]
        public async Task<ActionResult<MemberViewDto>> GetMember(int id)
        {
            var member = await _context.ClassMembers.FindAsync(id);

            if (member == null)
            {
                return NotFound();
            }

            return new MemberViewDto
            {
                Id = member.Id,
                FullName = member.FullName,
                StudentId = member.StudentId,
                DateOfBirth = member.DateOfBirth,
                PhoneNumber = member.PhoneNumber,
                Position = member.Position,
                ClassId = member.ClassId
            };
        }

        // POST: api/Members
        [HttpPost]
        public async Task<ActionResult<MemberViewDto>> PostMember(MemberCreateDto memberDto)
        {
            var member = new ClassMember
            {
                FullName = memberDto.FullName,
                StudentId = memberDto.StudentId,
                DateOfBirth = memberDto.DateOfBirth,
                PhoneNumber = memberDto.PhoneNumber,
                Position = memberDto.Position,
                ClassId = memberDto.ClassId
            };

            _context.ClassMembers.Add(member);
            await _context.SaveChangesAsync();

            var memberView = new MemberViewDto
            {
                Id = member.Id,
                FullName = member.FullName,
                StudentId = member.StudentId,
                DateOfBirth = member.DateOfBirth,
                PhoneNumber = member.PhoneNumber,
                Position = member.Position,
                ClassId = member.ClassId
            };

            return CreatedAtAction("GetMember", new { id = member.Id }, memberView);
        }

        // PUT: api/Members/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMember(int id, MemberUpdateDto memberDto)
        {
            var member = await _context.ClassMembers.FindAsync(id);
            if (member == null)
            {
                return NotFound();
            }

            member.FullName = memberDto.FullName;
            member.StudentId = memberDto.StudentId;
            member.DateOfBirth = memberDto.DateOfBirth;
            member.PhoneNumber = memberDto.PhoneNumber;
            member.Position = memberDto.Position;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MemberExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Members/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMember(int id)
        {
            var member = await _context.ClassMembers.FindAsync(id);
            if (member == null)
            {
                return NotFound();
            }

            _context.ClassMembers.Remove(member);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MemberExists(int id)
        {
            return _context.ClassMembers.Any(e => e.Id == id);
        }
    }
}
