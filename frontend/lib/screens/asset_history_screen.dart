// Đường dẫn: lib/screens/asset_history_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_session.dart';

class AssetHistoryScreen extends StatefulWidget {
  const AssetHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AssetHistoryScreen> createState() => _AssetHistoryScreenState();
}

class _AssetHistoryScreenState extends State<AssetHistoryScreen> {
  // Hàm chuyển đổi màu sắc chuyên nghiệp
  Color _getStatusColor(String colorString) {
    switch (colorString) {
      case 'green': return Colors.green;
      case 'orange': return Colors.orange; 
      case 'blue': return Colors.blue;
      case 'purple': return Colors.purple;
      default: return Colors.grey;
    }
  }

  // Hàm xử lý xóa lịch sử (Dành cho Admin)
  void _clearHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xóa lịch sử?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Bạn có chắc chắn muốn xóa toàn bộ lịch sử mượn trả tài sản không? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('HỦY', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              setState(() {
                AppSession.assetLogs.clear(); // Xóa sạch dữ liệu trong kho
              });
              Navigator.pop(context); // Đóng Dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã dọn dẹp sổ lịch sử!')),
              );
            },
            child: const Text('XÓA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Lấy dữ liệu và kiểm tra quyền Admin
    final List<Map<String, String>> historyData = AppSession.assetLogs;
    final user = AppSession.currentUser ?? AppSession.mockStudent;
    final bool isAdmin = user.role == 'admin';

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Đổi màu nền xám nhạt cho Card nổi bật hơn
      appBar: AppBar(
        title: const Text(
          'Lịch sử mượn trả',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true, // Căn giữa tiêu đề cho chuẩn app hiện đại
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // 🔥 CHỈ ADMIN MỚI ĐƯỢC QUYỀN XÓA LỊCH SỬ
          if (isAdmin && historyData.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Dọn dẹp lịch sử',
              onPressed: _clearHistory,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: historyData.isEmpty 
        ? _buildEmptyState() 
        : ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: historyData.length,
            itemBuilder: (context, index) {
              final log = historyData[index];
              final Color statusColor = _getStatusColor(log['color']!);

              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dòng 1: Header (Icon + Tên + Status)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: statusColor.withOpacity(0.1),
                          child: Icon(Icons.person_outline, size: 18, color: statusColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            log['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        _buildStatusChip(log['status']!, statusColor),
                      ],
                    ),
                    const Divider(height: 24, thickness: 0.5),

                    // Dòng 2: Thông tin thiết bị
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            log['item']!,
                            style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Dòng 3: Thời gian
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          log['date']!,
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  // Widget Chip trạng thái chuẩn UI ClassPal
  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Màn hình khi chưa có lịch sử
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          const Text(
            'Chưa có hoạt động nào',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}