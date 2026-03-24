import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String status;
  final IconData? leadingIcon;

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    this.leadingIcon,
  }) : super(key: key);

  // 🔥 Helper để lấy màu sắc theo trạng thái
  Color _getStatusColor() {
    switch (status) {
      case 'Đang diễn ra': return Colors.green;
      case 'Sắp diễn ra': return Colors.orange;
      case 'Đã kết thúc': return Colors.grey;
      default: return const Color(0xFF00E5FF); // Màu Cyan đặc trưng
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 0, // Tắt bóng đổ để dùng border nhìn sẽ hiện đại hơn
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          isThreeLine: true, // Hỗ trợ hiển thị 2 dòng ở subtitle tốt hơn
          leading: leadingIcon != null 
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(leadingIcon, color: statusColor, size: 24),
              )
            : null,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    );
  }
}