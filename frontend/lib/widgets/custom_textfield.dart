import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller; // 🔥 Cực kỳ quan trọng để lấy dữ liệu
  final IconData? prefixIcon;             // 🔥 Icon ở đầu cho chuyên nghiệp

  const CustomTextField({
    super.key, // Syntax Flutter mới cực gọn
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: prefixIcon != null 
            ? Icon(prefixIcon, color: const Color(0xFF00E5FF), size: 20) 
            : null,
        filled: true,
        fillColor: Colors.grey.shade50, // Nền xám nhạt nhìn rất "sang"
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        
        // Viền khi bình thường
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        
        // Viền khi người dùng bấm vào (Màu Cyan ClassPal)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
        ),
      ),
    );
  }
}