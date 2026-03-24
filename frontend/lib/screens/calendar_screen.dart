// Đường dẫn: lib/screens/calendar_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_session.dart';
import '../models/user_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime(2026, 3, 1); 
  int _selectedDay = 23;
  
  // Màu chủ đạo mới của App
  final Color primaryOrange = const Color(0xFFF05123);

  final Map<int, List<Map<String, dynamic>>> _taskData = {
    23: [
      {'title': 'Bảo trì máy chủ - Tầng 5', 'time': '08:00 - 10:00', 'status': 'Đang diễn ra', 'color': Colors.green},
      {'title': 'Họp giao ban tuần', 'time': '14:00 - 15:30', 'status': 'Sắp diễn ra', 'color': Colors.orange},
    ],
    24: [
      {'title': 'Giặt giẻ lau bảng', 'time': '07:00 - 07:15', 'status': 'Chưa bắt đầu', 'color': Colors.grey},
      {'title': 'Trực nhật Tổ 2', 'time': '17:00 - 18:00', 'status': 'Chưa bắt đầu', 'color': Colors.grey},
    ],
  };

  int _getDaysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  void _changeMonth(int offset) {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + offset, 1);
    });
  }

  // 🔥 HIỆN FORM THÊM CÔNG VIỆC MỚI
  void _showAddTaskModal() {
    final TextEditingController titleCtrl = TextEditingController();
    final TextEditingController timeCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20, right: 20, top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thêm công việc mới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Tên công việc', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: timeCtrl,
                decoration: const InputDecoration(labelText: 'Thời gian (VD: 14:00 - 15:00)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange, 
                    padding: const EdgeInsets.symmetric(vertical: 14)
                  ),
                  onPressed: () {
                    if (titleCtrl.text.isNotEmpty) {
                      setState(() {
                        if (_taskData[_selectedDay] == null) _taskData[_selectedDay] = [];
                        _taskData[_selectedDay]!.insert(0, {
                          'title': titleCtrl.text,
                          'time': timeCtrl.text.isEmpty ? 'Cả ngày' : timeCtrl.text,
                          'status': 'Chưa bắt đầu',
                          'color': Colors.grey
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã thêm công việc thành công!')));
                    }
                  },
                  child: const Text('LƯU CÔNG VIỆC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Lấy user và check Role an toàn (Chống null)
    final UserModel? user = AppSession.currentUser;
    final bool isAdmin = user?.role == 'admin';

    int daysCount = _getDaysInMonth(_focusedDay.year, _focusedDay.month);
    String monthLabel = "Tháng ${_focusedDay.month}, ${_focusedDay.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lịch Công Tác', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => _changeMonth(-1)),
                    Text(monthLabel, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.chevron_right), onPressed: () => _changeMonth(1)),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: daysCount,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final bool isSelected = day == _selectedDay;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDay = day),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? primaryOrange : Colors.transparent, // 🔥 Đổi màu Cam
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? primaryOrange : Colors.grey.shade100),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(thickness: 4, color: Color(0xFFF5F5F5)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  'Danh sách công việc ngày $_selectedDay',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...(_taskData[_selectedDay] ?? []).map((task) => _buildTaskCard(
                  context,
                  title: task['title'],
                  time: task['time'],
                  status: task['status'],
                  statusColor: task['color'],
                )).toList(),
                if ((_taskData[_selectedDay] ?? []).isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(child: Text('Không có công việc nào', style: TextStyle(color: Colors.grey))),
                  ),
              ],
            ),
          ),
        ],
      ),
      
      // 🔥 NÚT CỘNG CHUẨN XÁC CHO ADMIN KÈM THEO FORM ĐIỀN
      floatingActionButton: isAdmin ? FloatingActionButton(
        backgroundColor: primaryOrange, // 🔥 Màu Cam theo Theme
        elevation: 4,
        onPressed: _showAddTaskModal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ) : null,

      // 🔥 ĐÃ DỌN SẠCH BOTTOM NAVIGATION BAR ĐỂ TRÁNH TRÙNG LẶP
    );
  }

  Widget _buildTaskCard(BuildContext context, {required String title, required String time, required String status, required Color statusColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.assignment_outlined, color: Colors.orangeAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(time, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}