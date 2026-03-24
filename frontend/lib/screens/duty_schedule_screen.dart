// Đường dẫn: lib/screens/duty_schedule_screen.dart

import 'package:flutter/material.dart';

class DutyScheduleScreen extends StatefulWidget {
  const DutyScheduleScreen({super.key});

  @override
  State<DutyScheduleScreen> createState() => _DutyScheduleScreenState();
}

class _DutyScheduleScreenState extends State<DutyScheduleScreen> {
  // Trạng thái ngày đang chọn
  int _selectedDate = 15;

  // Màu chủ đạo Cyan theo thiết kế
  final Color primaryCyan = const Color(0xFF00D1FF);

  // Dữ liệu mô phỏng các ca trực
  final List<Map<String, dynamic>> _dutyTasks = [
    {
      'shift': 'Ca sáng, 07:00 - 12:00',
      'icon': Icons.wb_sunny_rounded,
      'iconColor': Colors.orangeAccent,
      'name': 'Nguyễn Văn A',
      'task': 'Kiểm tra hệ thống, báo cáo sự cố',
      'isCompleted': true,
    },
    {
      'shift': 'Ca chiều, 13:00 - 18:00',
      'icon': Icons.nightlight_round_sharp, // Dùng tạm icon trăng khuyết
      'iconColor': Colors.deepPurple,
      'name': 'Trần Thị B',
      'task': 'Bảo trì máy chủ, cập nhật phần mềm',
      'isCompleted': false,
    },
    {
      'shift': 'Ca đêm, 19:00 - 06:00',
      'icon': Icons.star_rounded,
      'iconColor': Colors.orangeAccent,
      'name': 'Lê Minh C',
      'task': 'Giám sát an ninh mạng, ghi nhật ký',
      'isCompleted': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Danh Sách Trực Nhật',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false, // Căn trái theo ảnh thiết kế
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mở bộ lọc')));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📅 PHẦN LỊCH TUẦN
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))
              ],
            ),
            child: Column(
              children: [
                // Header: Tháng & Toggle Tuần/Tháng
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Tháng 5, 2024',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.chevron_left, size: 20, color: Colors.grey.shade400),
                          Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade400),
                        ],
                      ),
                      // Nút gạt Tuần / Tháng
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)]),
                              child: const Text('Tuần', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Text('Tháng', style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Lưới Thứ & Ngày
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDayColumn('T2', 13),
                    _buildDayColumn('T3', 14),
                    _buildDayColumn('T4', 15),
                    _buildDayColumn('T5', 16),
                    _buildDayColumn('T6', 17),
                    _buildDayColumn('SA', 18),
                    _buildDayColumn('CN', 19),
                  ],
                ),
              ],
            ),
          ),
          
          // 📝 TIÊU ĐỀ: CHI TIẾT CÔNG VIỆC
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Text(
              'Chi tiết công việc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),

          // 📝 DANH SÁCH CA TRỰC
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: _dutyTasks.length,
              itemBuilder: (context, index) {
                final task = _dutyTasks[index];
                return _buildDutyCard(
                  shift: task['shift'],
                  icon: task['icon'],
                  iconColor: task['iconColor'],
                  name: task['name'],
                  taskDesc: task['task'],
                  isCompleted: task['isCompleted'],
                  onSwitchChanged: (value) {
                    setState(() {
                      _dutyTasks[index]['isCompleted'] = value;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Cột Ngày trong tuần
  Widget _buildDayColumn(String weekday, int date) {
    bool isSelected = date == _selectedDate;
    return GestureDetector(
      onTap: () => setState(() => _selectedDate = date),
      child: Column(
        children: [
          Text(weekday, style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: isSelected ? primaryCyan : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                date.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade400,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Chấm xanh nhỏ ở dưới
          CircleAvatar(
            radius: 3,
            backgroundColor: isSelected ? primaryCyan : (date < 19 ? primaryCyan.withOpacity(0.5) : Colors.transparent),
          )
        ],
      ),
    );
  }

  // Thẻ Nhiệm vụ trực nhật giống ảnh
  Widget _buildDutyCard({
    required String shift,
    required IconData icon,
    required Color iconColor,
    required String name,
    required String taskDesc,
    required bool isCompleted,
    required ValueChanged<bool> onSwitchChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // Nền xám cực nhạt
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Icon + Ca trực
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(shift, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),
          
          // Row 2: Avatar + Tên người trực + Switch
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blueAccent, // Thay bằng ảnh thật nếu có NetworkImage
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
              // Nút Switch tùy chỉnh
              SizedBox(
                height: 24, // Thu nhỏ chiều cao switch
                child: Switch(
                  value: isCompleted,
                  onChanged: onSwitchChanged,
                  activeColor: Colors.white,
                  activeTrackColor: primaryCyan,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Row 3: Chi tiết công việc + Chữ Hoàn thành
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  taskDesc,
                  style: TextStyle(fontSize: 14, color: Colors.black87.withOpacity(0.8)),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                isCompleted ? 'Hoàn thành' : 'Chưa hoàn thành',
                style: TextStyle(
                  fontSize: 13,
                  color: isCompleted ? Colors.black87 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}