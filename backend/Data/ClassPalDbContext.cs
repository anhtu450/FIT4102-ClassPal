using ClassPal.Backend.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace ClassPal.Backend.Data
{
    public class ClassPalDbContext : IdentityDbContext<ApplicationUser>
    {
        public ClassPalDbContext(DbContextOptions<ClassPalDbContext> options) : base(options)
        {
        }

        public DbSet<ClassInfo> ClassInfos { get; set; }
        public DbSet<ClassMember> ClassMembers { get; set; }
        public DbSet<FundTransaction> FundTransactions { get; set; }
        public DbSet<ActivityEvent> ActivityEvents { get; set; }
        public DbSet<Attendance> Attendances { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            
            // Configure relationships if needed
            builder.Entity<FundTransaction>()
                .Property(f => f.Amount)
                .HasColumnType("decimal(18, 2)");

            // Fix for SQL Server: Introducing FOREIGN KEY constraint may cause cycles or multiple cascade paths
            builder.Entity<Attendance>()
                .HasOne(a => a.Event)
                .WithMany()
                .HasForeignKey(a => a.EventId)
                .OnDelete(DeleteBehavior.Restrict);

            builder.Entity<Attendance>()
                .HasOne(a => a.Member)
                .WithMany()
                .HasForeignKey(a => a.MemberId)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}
