import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isPassword; // 🔥 Thêm để ẩn mật khẩu
  final TextEditingController? controller; // 🔥 Thêm để lấy dữ liệu
  final IconData? prefixIcon; // 🔥 Thêm icon cho đẹp (VD: Icons.email)

  const CustomTextField({
    super.key, // Dùng syntax mới cho gọn
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.isPassword = false,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nhãn của ô nhập liệu
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8.0),
        
        // Ô nhập liệu chính
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: isPassword,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: const Color(0xFF00E5FF), size: 20) : null,
            filled: true,
            fillColor: Colors.grey.shade50, // Nền xám nhạt cực sang
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            
            // Viền khi ở trạng thái bình thường
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            
            // Viền khi người dùng bấm vào (Focus)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
            ),
            
            // Viền khi có lỗi (nếu cần dùng sau này)
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}