import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient? gradient;
  final IconData? icon;
  final double height; // 🔥 Thêm chiều cao để dễ căn chỉnh

  const CustomButton({
    super.key, // 🔥 Syntax Dart mới: Gọn hơn rất nhiều
    required this.text,
    required this.onPressed,
    this.gradient,
    this.icon,
    this.height = 55.0, // Mặc định cao 55px cho chuẩn Mobile
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 Cứu cánh: Nếu không truyền gradient, mình dùng màu Cyan thương hiệu ClassPal
    final effectiveGradient = gradient ?? const LinearGradient(
      colors: [Color(0xFF00E5FF), Color(0xFF00B8D4)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      width: double.infinity, // Nút tự động tràn hết chiều ngang cho đẹp
      height: height,
      decoration: BoxDecoration(
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(16), // Bo góc 16 cho hiện đại
        boxShadow: [
          BoxShadow(
            color: effectiveGradient.colors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 22, color: Colors.white),
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}