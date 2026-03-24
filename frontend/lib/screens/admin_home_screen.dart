import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/app_session.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  static const Color primaryOrange = Color(0xFFF05123);

  // Danh sách công việc giả lập
  List<Map<String, dynamic>> tasks = [
    {'title': 'Tổng hợp điểm danh tuần 12', 'isCompleted': true},
    {'title': 'Chuẩn bị nội dung họp phụ huynh', 'isCompleted': false},
    {'title': 'Duyệt chi tiền mua hoa kỷ niệm', 'isCompleted': false},
  ];

  @override
  Widget build(BuildContext context) {
    int completedTasks = tasks.where((task) => task['isCompleted']).length;
    final UserModel user = AppSession.currentUser ?? AppSession.mockAdmin;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // --- 1. HEADER ---
              _buildHeader(user),

              const SizedBox(height: 32),

              // --- 2. CARD TỔNG QUỸ ---
              _buildFundCard(),

              const SizedBox(height: 32),

              // --- 3. CÔNG CỤ QUẢN LÝ (LƯỚI 3 CỘT) ---
              const Text(
                'Công cụ quản lý',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
              ),
              const SizedBox(height: 20),
              
              _buildToolGrid(),

              const SizedBox(height: 32),

              // --- 4. VIỆC CẦN LÀM ---
              _buildSectionHeader('Việc cần làm', '$completedTasks/${tasks.length} Xong'),
              const SizedBox(height: 16),
              ...tasks.asMap().entries.map((entry) {
                int idx = entry.key;
                var task = entry.value;
                return _buildTaskItem(task['title'], task['isCompleted'], () {
                  setState(() => tasks[idx]['isCompleted'] = !tasks[idx]['isCompleted']);
                });
              }),

              const SizedBox(height: 32),

              // --- 5. LỊCH TRÌNH ---
              const Text('Lịch trình sắp tới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildEventItem('TH5', '25', 'Họp BCH Đoàn trường', '08:00 AM • Văn phòng Đoàn', true),
              _buildEventItem('TH6', '26', 'Tổng duyệt Văn nghệ', '15:30 PM • Hội trường G', false),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET CÔNG CỤ QUẢN LÝ ---
  Widget _buildToolGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildToolItem(Icons.calendar_month_rounded, 'Lịch công tác', '/calendar', Colors.blue),
            _buildToolItem(Icons.cleaning_services_rounded, 'Trực nhật', '/duty_schedule', Colors.green),
            _buildToolItem(Icons.assignment_turned_in_outlined, 'Duyệt chi', '/expense_log', Colors.purple),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildToolItem(Icons.description_outlined, 'Báo cáo TC', '/finance_report', Colors.teal),
            _buildToolItem(Icons.insights_rounded, 'Chi tiết quỹ', '/fund_details', Colors.indigo),
            _buildToolItem(Icons.event_note_rounded, 'Sự kiện', '/event_list', Colors.orange),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            // Nút Dashboard quyền lực của sếp
            _buildToolItem(Icons.analytics_rounded, 'Dashboard', '/event_admin_dashboard', Colors.deepPurple),
          ],
        ),
      ],
    );
  }

  // --- CÁC WIDGET PHỤ TRỢ ---

  Widget _buildHeader(UserModel user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chào, ${user.name} 👋',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
            ),
            const Text(
              'Bảng điều khiển Cán sự lớp',
              style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        _buildTopNotification(),
      ],
    );
  }

  Widget _buildTopNotification() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: primaryOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
          child: IconButton(
            icon: const Icon(Icons.notifications_active_outlined, color: primaryOrange),
            onPressed: () => Navigator.pushNamed(context, '/reminder'),
          ),
        ),
        Positioned(
          right: 10, top: 10,
          child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
        )
      ],
    );
  }

  Widget _buildFundCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          const Text('TỔNG QUỸ LỚP HIỆN TẠI', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.2)),
          const SizedBox(height: 12),
          const Text('15.250.000 đ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: primaryOrange)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _miniFundButton(Icons.add_circle_outline, 'Thu quỹ', Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _miniFundButton(Icons.remove_circle_outline, 'Chi phí', Colors.redAccent)),
            ],
          )
        ],
      ),
    );
  }

  Widget _miniFundButton(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildToolItem(IconData icon, String label, String route, Color color) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 48 - 40) / 3, 
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16), 
              decoration: BoxDecoration(
                color: color.withOpacity(0.08), 
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: color.withOpacity(0.1))
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              label, 
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.bold, 
                color: Color(0xFF374151),
                height: 1.2,
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String badge) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: primaryOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Text(badge, style: const TextStyle(color: primaryOrange, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildTaskItem(String title, bool isCompleted, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: isCompleted ? Colors.white : const Color(0xFFF9FAFB), 
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: isCompleted ? Colors.grey.shade100 : Colors.transparent)
        ),
        child: Row(
          children: [
            Icon(isCompleted ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded, color: isCompleted ? primaryOrange : Colors.grey.shade400),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title, 
                style: TextStyle(
                  fontWeight: FontWeight.w600, 
                  color: isCompleted ? Colors.grey : Colors.black87, 
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                  fontSize: 14
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventItem(String month, String day, String title, String time, bool isHighlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade50)
      ),
      child: Row(
        children: [
          Container(
            width: 58, height: 58,
            decoration: BoxDecoration(
              color: isHighlight ? primaryOrange : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(month, style: TextStyle(fontSize: 10, color: isHighlight ? Colors.white70 : Colors.grey, fontWeight: FontWeight.bold)),
                Text(day, style: TextStyle(fontSize: 18, color: isHighlight ? Colors.white : Colors.black, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF111827))), 
                const SizedBox(height: 4), 
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                )
              ]
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}