import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String name;
  final String code;
  final String? location;
  final String? borrower;
  final String? returnTime;
  final String? expectedCompletion;
  final String status;
  final String statusColor;
  final String icon;
  final VoidCallback? onTap;

  const AssetCard({
    Key? key,
    required this.name,
    required this.code,
    this.location,
    this.borrower,
    this.returnTime,
    this.expectedCompletion,
    required this.status,
    required this.statusColor,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  // Hàm lấy màu chuẩn (Đã nâng cấp sang kiểu nhạt nền - đậm chữ)
  Color _getColor() {
    switch (statusColor) {
      case 'green': return Colors.green;
      case 'orange': return Colors.orange;
      case 'blue': return Colors.blue;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getColor();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0, // Tắt bóng đổ mặc định để dùng border cho hiện đại
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell( // 🔥 Đã đổi sang InkWell để có hiệu ứng sóng nước
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📦 ICON THIẾT BỊ
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_getIconData(icon), color: themeColor, size: 30),
              ),
              const SizedBox(width: 16),
              
              // 📝 NỘI DUNG
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text('Mã: $code', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    
                    // Hiển thị thông tin linh hoạt nếu không null
                    if (location != null) _buildInfoRow(Icons.location_on_outlined, 'Vị trí: $location'),
                    if (borrower != null) _buildInfoRow(Icons.person_outline, 'Mượn bởi: $borrower'),
                    if (returnTime != null) _buildInfoRow(Icons.access_time, 'Hạn trả: $returnTime'),
                    if (expectedCompletion != null) _buildInfoRow(Icons.build_circle_outlined, 'Xong: $expectedCompletion'),
                  ],
                ),
              ),
              
              // 🏷️ TRẠNG THÁI (BADGE)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: themeColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget phụ để vẽ các dòng thông tin nhỏ cho đẹp
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'projector': return Icons.videocam_outlined;
      case 'remote': return Icons.settings_remote_outlined;
      case 'laptop': return Icons.laptop_mac_outlined;
      case 'headphones': return Icons.headphones_outlined;
      case 'bike': return Icons.pedal_bike_outlined;
      default: return Icons.inventory_2_outlined;
    }
  }
}