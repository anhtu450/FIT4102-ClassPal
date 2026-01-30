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

        // Định nghĩa các bảng (DbSet) ở đây
        // public DbSet<Duty> Duties { get; set; }
        // public DbSet<Asset> Assets { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            // Custom configurations (Fluent API) go here
        }
    }
}
