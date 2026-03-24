// Đường dẫn: lib/screens/student_home_screen.dart

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/app_session.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final Color primaryOrange = const Color(0xFFF05123);

  final List<Map<String, dynamic>> _myTasks = [
    {'title': 'Bài tập Giải tích 2', 'time': 'Hôm nay, 23:59', 'icon': Icons.book_rounded, 'isDone': false},
    {'title': 'Họp nhóm đồ án', 'time': 'Ngày mai, 09:00', 'icon': Icons.groups_rounded, 'isDone': false},
    {'title': 'Nộp báo cáo thực tập', 'time': 'Đã hoàn thành', 'icon': Icons.check_circle_rounded, 'isDone': true},
  ];

  @override
  Widget build(BuildContext context) {
    final UserModel user = AppSession.currentUser ?? AppSession.mockStudent;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. HEADER ---
              _buildHeader(user),
              const SizedBox(height: 24),

              // --- 2. CARD HẠN ĐÓNG QUỸ (ĐÃ FIX NÚT BẤM) ---
              _buildFundDueCard(),
              const SizedBox(height: 32),

              // --- 3. LỊCH TRỰC NHẬT HÔM NAY ---
              _buildSectionHeader('Trực nhật hôm nay', 'Xem lịch', '/duty_schedule'),
              _buildDutyQuickView(),
              const SizedBox(height: 32),

              // --- 4. NHIỆM VỤ CỦA TÔI ---
              _buildSectionHeader('Nhiệm vụ của tôi', 'Xem tất cả', '/task_list'),
              const SizedBox(height: 12),
              ...List.generate(_myTasks.length, (index) {
                return _buildTaskItem(index, _myTasks[index]);
              }),
              const SizedBox(height: 32),

              // --- 5. TIẾN ĐỘ HỌC TẬP ---
              const Text('Tiến độ học tập', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildProgressCard('TRUNG BÌNH', '3.8', '/ 4.0', Colors.green),
                  const SizedBox(width: 16),
                  _buildProgressCard('TÍN CHỈ', '115', '/ 140', Colors.orange),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildHeader(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=student_tu'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chào buổi sáng,', style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
                Text('${user.name} 👋', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF111827))),
              ],
            ),
          ],
        ),
        _buildNotificationIcon(),
      ],
    );
  }

  Widget _buildFundDueCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('HẠN ĐÓNG QUỸ LỚP', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
                child: const Text('Hạn: 30 Th10', style: TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('250.000đ', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Color(0xFF111827))),
          const SizedBox(height: 12),
          Text('Bạn chưa hoàn thành đóng quỹ học kỳ I của năm học 2023-2024.', style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.5)),
          const SizedBox(height: 24),
          
          // 🔥 ĐÃ FIX: Nút bấm điều hướng đến trang Chi tiết quỹ
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Điều hướng đến Route đã đăng ký trong main.dart
                Navigator.pushNamed(context, '/fund_details');
                
                // Hiển thị thông báo nhỏ để tăng trải nghiệm
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đang chuyển đến trang chi tiết quỹ lớp...'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryOrange,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 8,
                shadowColor: primaryOrange.withOpacity(0.4),
              ),
              child: const Text('Đóng quỹ ngay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // --- CÁC WIDGET PHỤ TRỢ KHÁC (GIỮ NGUYÊN) ---

  Widget _buildNotificationIcon() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(14)),
      child: Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF111827), size: 26),
            onPressed: () => Navigator.pushNamed(context, '/reminder'),
          ),
          Positioned(
            right: 12, top: 12,
            child: Container(
              width: 8, height: 8,
              decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, String route) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, route),
          child: Text(action, style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildDutyQuickView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.cleaning_services_rounded, color: Colors.green, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nhóm 3 trực nhật', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text('Vệ sinh lớp & tắt thiết bị điện', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildTaskItem(int index, Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Icon(task['icon'], color: primaryOrange, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF111827))),
                Text(task['time'], style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              ],
            ),
          ),
          Switch(
            value: task['isDone'],
            activeColor: Colors.white,
            activeTrackColor: primaryOrange,
            onChanged: (val) => setState(() => _myTasks[index]['isDone'] = val),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String label, String value, String total, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade500, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: color)),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(total, style: TextStyle(fontSize: 14, color: Colors.grey.shade400, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}