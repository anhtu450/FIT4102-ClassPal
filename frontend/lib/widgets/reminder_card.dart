import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String name;
  final String role;
  final bool isImportant;
  final VoidCallback? onNotify; // 🔥 Thêm callback để xử lý khi bấm nút chuông

  const ReminderCard({
    super.key, // Syntax Dart mới
    required this.name,
    required this.role,
    this.isImportant = false,
    this.onNotify,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 Màu chủ đạo: Đỏ cho quan trọng, Cyan cho bình thường
    final Color themeColor = isImportant ? Colors.redAccent : const Color(0xFF00E5FF);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isImportant ? themeColor.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isImportant ? themeColor.withOpacity(0.2) : Colors.grey.shade100,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 👤 AVATAR: Hiển thị chữ cái đầu của tên
            CircleAvatar(
              radius: 26,
              backgroundColor: themeColor.withOpacity(0.1),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // 📝 THÔNG TIN NGƯỜI NHẬN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      if (isImportant) ...[
                        const SizedBox(width: 6),
                        const Icon(Icons.error_outline, size: 14, color: Colors.redAccent),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // 🔔 NÚT GỬI LỜI NHẮC
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onNotify,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isImportant ? Icons.notifications_active_rounded : Icons.notifications_none_rounded,
                    color: themeColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}