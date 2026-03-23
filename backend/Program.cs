using backend.Data;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore; // Sử dụng thư viện Scalar mới

var builder = WebApplication.CreateBuilder(args);

// Kết nối SQL Server
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Thêm Controller
builder.Services.AddControllers();

// Đăng ký OpenAPI chuẩn của .NET 9
builder.Services.AddOpenApi(); 

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    // Cấu hình giao diện Scalar web
    app.MapOpenApi();
    app.MapScalarApiReference(); 
}

app.UseHttpsRedirection();
app.MapControllers();
app.Run();