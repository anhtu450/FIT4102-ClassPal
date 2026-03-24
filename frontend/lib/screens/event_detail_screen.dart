import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // 🔥 Đảm bảo đã thêm thư viện này vào pubspec.yaml
import 'dart:math';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  // 🔥 Quản lý máy bắn pháo hoa
  late ConfettiController _confettiController;
  bool _isRegistered = false; // Trạng thái giả lập để đổi màu nút

  @override
  void initState() {
    super.initState();
    // Khởi tạo pháo hoa bắn trong 1 giây
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Tắt máy bắn khi thoát trang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. NHẬN DỮ LIỆU TỪ TRANG DANH SÁCH
    final event = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chi tiết sự kiện',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack( // Dùng Stack để đè pháo hoa lên trên nội dung
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼️ 2. ẢNH BÌA LOCAL (Đã đồng bộ với Asset)
                Image.asset(
                  event['image'],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image_outlined, color: Colors.grey, size: 50),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên sự kiện
                      Text(
                        event['title'],
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 20),
                      
                      // Dòng Thời gian
                      _buildInfoRow(
                        Icons.calendar_today_rounded, 
                        Colors.blue, 
                        '${event['date']}, ${event['time']}'
                      ),
                      const SizedBox(height: 16),
                      
                      // Dòng Địa điểm
                      _buildInfoRow(
                        Icons.location_on_rounded, 
                        Colors.redAccent, 
                        'Hội trường G, Đại học Đại Nam'
                      ),
                      const SizedBox(height: 32),
                      
                      // Mô tả chi tiết
                      const Text(
                        'Thông tin sự kiện',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        event['desc'] ?? 'Chưa có mô tả chi tiết cho sự kiện này.',
                        style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.6),
                      ),
                      const SizedBox(height: 32),

                      // 🗺️ VỊ TRÍ
                      const Text(
                        'Vị trí',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 12),
                      _buildFakeMap(),
                      const SizedBox(height: 100), // Khoảng trống cuối để không bị nút đè
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔥 HIỆU ỨNG PHÁO HOA TUNG TÓE
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Bắn thẳng xuống
              maxBlastForce: 5, 
              minBlastForce: 2, 
              emissionFrequency: 0.05,
              numberOfParticles: 20, 
              gravity: 0.1,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
      
      // 🟢 3. NÚT ĐĂNG KÝ THÔNG MINH
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  // Widget dòng thông tin
  Widget _buildInfoRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
          ),
        ),
      ],
    );
  }

  // Widget bản đồ ảo
  Widget _buildFakeMap() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 8))],
        image: const DecorationImage(
          image: NetworkImage('http://googleusercontent.com/maps.google.com/2'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.location_pin, color: Colors.red, size: 30),
        ),
      ),
    );
  }

  // Nút bấm dưới cùng kèm hiệu ứng
  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          // Đổi màu sang Xám nếu đã đăng ký
          gradient: _isRegistered ? null : const LinearGradient(colors: [Color(0xFFE91E63), Color(0xFFF05123)]),
          color: _isRegistered ? Colors.grey.shade300 : null,
          borderRadius: BorderRadius.circular(18),
          boxShadow: _isRegistered ? null : [BoxShadow(color: const Color(0xFFF05123).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: ElevatedButton(
          onPressed: _isRegistered ? null : () {
            setState(() {
              _isRegistered = true;
            });
            
            // 🔥 BẮN PHÁO HOA!
            _confettiController.play();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎉 Chúc mừng! Sếp đã đăng ký tham gia thành công.'), 
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          child: Text(
            _isRegistered ? 'Đã đăng ký tham gia ✓' : 'Đăng ký tham gia ngay',
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold, 
              color: _isRegistered ? Colors.grey.shade600 : Colors.white
            ),
          ),
        ),
      ),
    );
  }
}