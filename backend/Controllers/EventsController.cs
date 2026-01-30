using ClassPal.Backend.Data;
using ClassPal.Backend.DTOs;
using ClassPal.Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ClassPal.Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventsController : ControllerBase
    {
        private readonly ClassPalDbContext _context;

        public EventsController(ClassPalDbContext context)
        {
            _context = context;
        }

        // GET: api/Events
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ActivityEventViewDto>>> GetEvents(int? classId)
        {
            var query = _context.ActivityEvents.AsQueryable();

            if (classId.HasValue)
            {
                query = query.Where(e => e.ClassId == classId);
            }

            return await query.Select(e => new ActivityEventViewDto
            {
                Id = e.Id,
                ClassId = e.ClassId,
                Name = e.Name,
                DateTime = e.DateTime,
                Location = e.Location,
                Description = e.Description
            }).OrderByDescending(e => e.DateTime).ToListAsync();
        }

        // POST: api/Events
        [HttpPost]
        public async Task<ActionResult<ActivityEventViewDto>> PostEvent(ActivityEventCreateDto eventDto)
        {
            var activityEvent = new ActivityEvent
            {
                ClassId = eventDto.ClassId,
                Name = eventDto.Name,
                DateTime = eventDto.DateTime,
                Location = eventDto.Location,
                Description = eventDto.Description
            };

            _context.ActivityEvents.Add(activityEvent);
            await _context.SaveChangesAsync();

            // Optional: Automatically initialize attendance records for all members?
            // For now, let's keep it simple and load them on demand.

            var eventView = new ActivityEventViewDto
            {
                Id = activityEvent.Id,
                ClassId = activityEvent.ClassId,
                Name = activityEvent.Name,
                DateTime = activityEvent.DateTime,
                Location = activityEvent.Location,
                Description = activityEvent.Description
            };

            return CreatedAtAction("GetEvents", new { id = activityEvent.Id }, eventView);
        }

        // GET: api/Events/5/attendance
        [HttpGet("{eventId}/attendance")]
        public async Task<ActionResult<IEnumerable<AttendanceViewDto>>> GetAttendance(int eventId)
        {
            var evt = await _context.ActivityEvents.FindAsync(eventId);
            if (evt == null) return NotFound("Event not found");

            // Check if attendance records exist
            var existingRecords = await _context.Attendances
                .Include(a => a.Member)
                .Where(a => a.EventId == eventId)
                .ToListAsync();

            if (!existingRecords.Any())
            {
                // If no records, maybe we should create them for all current members?
                // Use a strategy: Return list of all members with default status "Present" (not saved yet) 
                // OR save them immediately. Let's return a list based on Members to be safe.
                
                var members = await _context.ClassMembers
                    .Where(m => m.ClassId == evt.ClassId)
                    .ToListAsync();

                // We won't save to DB yet, just return the view
                return members.Select(m => new AttendanceViewDto
                {
                    Id = 0, // Not saved
                    EventId = eventId,
                    MemberId = m.Id,
                    MemberName = m.FullName,
                    MemberStudentId = m.StudentId,
                    Status = "Present", // Default
                    Note = null
                }).ToList();
            }

            return existingRecords.Select(a => new AttendanceViewDto
            {
                Id = a.Id,
                EventId = a.EventId,
                MemberId = a.MemberId,
                MemberName = a.Member != null ? a.Member.FullName : "Unknown",
                MemberStudentId = a.Member != null ? a.Member.StudentId : "",
                Status = a.Status,
                Note = a.Note
            }).ToList();
        }

        // POST: api/Events/5/attendance
        [HttpPost("{eventId}/attendance")]
        public async Task<IActionResult> UpdateAttendance(int eventId, [FromBody] List<AttendanceUpdateDto> attendanceUpdates)
        {
            var evt = await _context.ActivityEvents.FindAsync(eventId);
            if (evt == null) return NotFound("Event not found");

            foreach (var update in attendanceUpdates)
            {
                var record = await _context.Attendances
                    .FirstOrDefaultAsync(a => a.EventId == eventId && a.MemberId == update.MemberId);

                if (record == null)
                {
                    // Create new
                    record = new Attendance
                    {
                        EventId = eventId,
                        MemberId = update.MemberId,
                        Status = update.Status,
                        Note = update.Note
                    };
                    _context.Attendances.Add(record);
                }
                else
                {
                    // Update existing
                    record.Status = update.Status;
                    record.Note = update.Note;
                    _context.Entry(record).State = EntityState.Modified;
                }
            }

            await _context.SaveChangesAsync();

            return Ok(new { message = "Attendance updated successfully" });
        }
        
        // DELETE: api/Events/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEvent(int id)
        {
            var evt = await _context.ActivityEvents.FindAsync(id);
            if (evt == null)
            {
                return NotFound();
            }

            // Remove related attendance records first (redundant if Cascade Delete was allowed, but we used Restrict)
            var attendanceRecords = await _context.Attendances.Where(a => a.EventId == id).ToListAsync();
            _context.Attendances.RemoveRange(attendanceRecords);

            _context.ActivityEvents.Remove(evt);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
