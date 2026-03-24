import 'package:flutter/material.dart';

class CustomTaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback? onTap; // 🔥 Đã khai báo biến chuẩn

  const CustomTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.onTap, // 🔥 Gắn vào constructor
  });

  @override
  Widget build(BuildContext context) {
    // Màu chủ đạo theo trạng thái
    final Color themeColor = isCompleted ? Colors.green : const Color(0xFF00E5FF);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0, // Tắt bóng đổ để dùng viền cho hiện đại
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade100), // Viền siêu mỏng
      ),
      child: InkWell( // 🔥 Thêm hiệu ứng sóng nước khi chạm
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                color: themeColor,
                size: 28,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isCompleted ? Colors.grey : Colors.black87,
                // Gạch ngang chữ nếu đã xong
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios, 
              size: 14, 
              color: Colors.black26
            ),
          ),
        ),
      ),
    );
  }
}