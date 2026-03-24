using backend.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Kết nối SQL Server
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddCors(options =>
    options.AddPolicy("AllowFlutter", p => p.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod()));

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();

// Dùng global:: để tránh lỗi Models
builder.Services.AddSwaggerGen(c => {
    c.SwaggerDoc("v1", new global::Microsoft.OpenApi.Models.OpenApiInfo { Title = "ClassPal API", Version = "v1" });
});

var app = builder.Build();

if (app.Environment.IsDevelopment()) {
    app.UseSwagger();
    app.UseSwaggerUI(c => { 
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "ClassPal v1");
        c.RoutePrefix = string.Empty; 
    });
}

app.UseCors("AllowFlutter");
app.MapControllers();
app.Run();