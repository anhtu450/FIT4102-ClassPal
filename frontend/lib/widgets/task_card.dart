import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String deadline;
  final IconData icon;
  final VoidCallback? onTap; // Khai báo biến để lưu hàm callback

  const TaskCard({
    super.key, // Sử dụng cú pháp super.key gọn hơn
    required this.title,
    required this.deadline,
    required this.icon,
    this.onTap, // Gán vào constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2, // Thêm một chút đổ bóng cho card nổi bật
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bo góc hiện đại hơn
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1), // Tạo nền nhạt cho icon
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 28,
            color: Colors.blue.shade700,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'Hạn: $deadline',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap, // Sử dụng giá trị truyền vào từ constructor
      ),
    );
  }
}