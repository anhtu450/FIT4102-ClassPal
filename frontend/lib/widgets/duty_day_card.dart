import 'package:flutter/material.dart';

class DutyDayCard extends StatelessWidget {
  final String shift;
  final String name;
  final String task;
  final bool isCompleted;
  final ValueChanged<bool>? onToggle; // 🔥 Thêm callback để xử lý gạt Switch

  const DutyDayCard({
    super.key, // Dùng syntax mới gọn hơn
    required this.shift,
    required this.name,
    required this.task,
    required this.isCompleted,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Màu chủ đạo theo trạng thái hoàn thành
    final Color themeColor = isCompleted ? Colors.green : const Color(0xFF00E5FF);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // CỘT THÔNG TIN BÊN TRÁI
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hiển thị Ca trực (Sáng/Chiều) dạng nhãn nhỏ
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      shift,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  
                  // Thông tin người trực
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: themeColor.withOpacity(0.2),
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : "?",
                          style: TextStyle(color: themeColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              task,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // NÚT GẠT XÁC NHẬN
            Column(
              children: [
                const Text(
                  'Xong',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Switch(
                  value: isCompleted,
                  onChanged: onToggle, // 🔥 Đã gắn callback để gạt được
                  activeColor: Colors.green, // Chuyển xanh lá khi xong
                  activeTrackColor: Colors.green.withOpacity(0.3),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}