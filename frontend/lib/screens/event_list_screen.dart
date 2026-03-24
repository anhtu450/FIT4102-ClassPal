import 'package:flutter/material.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  // 📝 Dữ liệu mẫu (Sau này Tú sẽ dùng FutureBuilder để gọi từ API ASP.NET nhé)
  final List<Map<String, dynamic>> _events = [
    {
      'id': 'EV001',
      'title': 'Hội thảo Hướng nghiệp 2024',
      'date': '15 Tháng 10, 2024',
      'time': '08:30 sáng',
      'status': 'MỚI',
      'image': 'assets/images/hoithao.jpg', 
      'desc': 'Cơ hội gặp gỡ các chuyên gia đầu ngành IT, định hướng con đường sự nghiệp sau khi tốt nghiệp tại Đại Nam.',
    },
    {
      'id': 'EV002',
      'title': 'Giải bóng đá ClassPal Cup',
      'date': '20 Tháng 10, 2024',
      'time': '15:00 chiều',
      'status': 'SẮP DIỄN RA',
      'image': 'assets/images/bongda.jpg', 
      'desc': 'Sân chơi thể thao sôi động dành cho các lớp IT. Cùng tranh tài để giành chiếc cúp vàng danh giá!',
    },
    {
      'id': 'EV003',
      'title': 'Triển lãm Nghệ thuật Sáng tạo',
      'date': '25 Tháng 10, 2024',
      'time': '09:00 sáng',
      'status': 'HOT',
      'image': 'assets/images/trienlam.jpg', 
      'desc': 'Không gian trưng bày các dự án sáng tạo, thiết kế UI/UX độc đáo từ các bạn sinh viên tài năng.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFF05123);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        surfaceTintColor: Colors.white,
        // Nút quay lại để thoát ra màn hình chính
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827), size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sự kiện',
              style: TextStyle(color: Color(0xFF111827), fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              'Khám phá hoạt động mới',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.black87),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tính năng tìm kiếm đang phát triển!')),
                );
              },
            ),
          ),
        ],
      ),

      // 🔥 NÚT TẠO MỚI (Dành cho Lớp trưởng điều hành)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/add_event'),
        label: const Text('Tạo Sự Kiện', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: primaryOrange,
        elevation: 4,
      ),

      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 100), // Padding dưới cao để không bị che bởi FAB
        itemCount: _events.length,
        separatorBuilder: (context, index) => const SizedBox(height: 28),
        itemBuilder: (context, index) => _buildEventCard(context, _events[index]),
      ),
    );
  }

  // WIDGET THẺ SỰ KIỆN
  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), 
            blurRadius: 20, 
            offset: const Offset(0, 8)
          )
        ],
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/event_detail', arguments: event),
        borderRadius: BorderRadius.circular(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 1. PHẦN HÌNH ẢNH
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  child: Image.asset(
                    event['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildImageError(),
                  ),
                ),
                if (event['status'].toString().isNotEmpty)
                  _buildStatusBadge(event['status']),
              ],
            ),
            
            // ℹ️ 2. PHẦN THÔNG TIN
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 16, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Text(
                        '${event['date']} • ${event['time']}',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // 🚀 3. NÚT THAM GIA
                  _buildJoinButton(context, event),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Color(0xFFF05123), 
            fontSize: 10, 
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5
          ),
        ),
      ),
    );
  }

  Widget _buildImageError() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: Colors.grey.shade400, size: 40),
          const SizedBox(height: 8),
          const Text("Thiếu file ảnh", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildJoinButton(BuildContext context, Map<String, dynamic> event) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFFF05123)], 
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF05123).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: () => Navigator.pushNamed(context, '/event_detail', arguments: event),
        child: const Text(
          'Tham gia ngay',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}