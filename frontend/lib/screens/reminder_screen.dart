// Đường dẫn: lib/screens/reminder_screen.dart

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/app_session.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final Color primaryOrange = const Color(0xFFF05123);

  // --- TRẠNG THÁI CHO ADMIN ---
  final List<String> _topics = ['Đóng quỹ lớp tháng 3', 'Trực nhật tuần 24', 'Nộp bài tập Giải tích'];
  String _selectedTopic = 'Đóng quỹ lớp tháng 3';
  
  // Lưu danh sách ID các sinh viên được chọn để tránh lỗi logic khi render lại
  final Set<String> _selectedStudentIds = {};

  @override
  Widget build(BuildContext context) {
    // 1. Lấy thông tin vai trò và danh sách sinh viên thật từ AppSession
    final user = AppSession.currentUser ?? AppSession.mockStudent;
    final bool isAdmin = user.role == 'admin';
    final List<UserModel> studentsInClass = AppSession.allStudents;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          isAdmin ? 'Gửi lời nhắc' : 'Thông báo của tôi',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // 2. TỰ ĐỘNG LẬT GIAO DIỆN DỰA TRÊN ROLE
      body: isAdmin 
          ? _buildAdminUI(studentsInClass) 
          : _buildStudentUI(AppSession.notifications),
    );
  }

  // -------------------------------------------------------------------
  // 📢 GIAO DIỆN CHO ADMIN (KẾT NỐI DỮ LIỆU ĐỘNG)
  // -------------------------------------------------------------------
  Widget _buildAdminUI(List<UserModel> studentList) {
    bool isAllSelected = _selectedStudentIds.length == studentList.length && studentList.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text('CHỦ ĐỀ NHẮC NHỞ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
        ),
        _buildTopicDropdown(),
        const SizedBox(height: 24),
        
        // Header danh sách
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DANH SÁCH LỚP (${studentList.length})', 
                style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 12)
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    if (isAllSelected) {
                      _selectedStudentIds.clear();
                    } else {
                      _selectedStudentIds.addAll(studentList.map((s) => s.studentId));
                    }
                  });
                },
                icon: Icon(isAllSelected ? Icons.check_circle : Icons.circle_outlined, size: 18, color: primaryOrange),
                label: Text(
                  isAllSelected ? 'Bỏ chọn hết' : 'Chọn tất cả',
                  style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // Danh sách sinh viên (Lấy từ AppSession)
        Expanded(
          child: studentList.isEmpty 
            ? const Center(child: Text('Lớp chưa có sinh viên nào', style: TextStyle(color: Colors.grey)))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: studentList.length,
                itemBuilder: (context, index) => _buildMemberCard(studentList[index]),
              ),
        ),
        
        // Nút gửi khẩn cấp
        _buildSendButton(_selectedStudentIds.length),
      ],
    );
  }

  // -------------------------------------------------------------------
  // 🔔 GIAO DIỆN CHO SINH VIÊN (NHẬN THÔNG BÁO)
  // -------------------------------------------------------------------
  Widget _buildStudentUI(List<Map<String, String>> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none_rounded, size: 80, color: Colors.grey.shade100),
            const SizedBox(height: 16),
            const Text('Hộp thư trống', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final item = notifications[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade100, width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['title']!, style: TextStyle(fontWeight: FontWeight.w900, color: primaryOrange)),
                  Text(item['time']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 12),
              Text(item['content']!, style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.4)),
            ],
          ),
        );
      },
    );
  }

  // --- COMPONENT CON CHO ADMIN ---

  Widget _buildTopicDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade50, 
          borderRadius: BorderRadius.circular(16), 
          border: Border.all(color: Colors.grey.shade100)
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedTopic,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: primaryOrange),
            items: _topics.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontWeight: FontWeight.bold)))).toList(),
            onChanged: (val) => setState(() => _selectedTopic = val!),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(UserModel student) {
    bool isSelected = _selectedStudentIds.contains(student.id);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) _selectedStudentIds.remove(student.studentId);
          else _selectedStudentIds.add(student.studentId);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryOrange.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? primaryOrange.withOpacity(0.3) : Colors.grey.shade100, width: 1.5),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? primaryOrange : Colors.grey.shade100, 
              child: Text(student.name[0], style: TextStyle(color: isSelected ? Colors.white : Colors.blueGrey, fontWeight: FontWeight.bold))
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), 
                  Text(student.studentId, style: const TextStyle(color: Colors.grey, fontSize: 12))
                ]
              )
            ),
            Checkbox(
              value: isSelected, 
              activeColor: primaryOrange, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              onChanged: (val) {
                setState(() {
                  if (val == true) _selectedStudentIds.add(student.studentId);
                  else _selectedStudentIds.remove(student.studentId);
                });
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton(int count) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        onPressed: count > 0 ? () {
          // 🔥 LOGIC: Thêm thông báo vào kho chung
          AppSession.notifications.insert(0, {
            'title': 'NHẮC NHỞ QUAN TRỌNG',
            'content': 'Lớp trưởng nhắc bạn thực hiện: $_selectedTopic',
            'time': 'Vừa xong'
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('🔔 Đã gửi nhắc nhở đến $count thành viên!')));
        } : null,
        icon: const Icon(Icons.campaign, color: Colors.white),
        label: Text(
          count > 0 ? 'NHẮC $count THÀNH VIÊN' : 'CHỌN NGƯỜI CẦN NHẮC', 
          style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white)
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent, 
          disabledBackgroundColor: Colors.grey.shade300, 
          minimumSize: const Size(double.infinity, 60), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
      ),
    );
  }
}