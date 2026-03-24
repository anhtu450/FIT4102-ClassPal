// Đường dẫn: lib/screens/task_list_v1_screen.dart

import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // 📝 Danh sách nhiệm vụ (Đưa vào State để có thể thêm/xóa)
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Nộp bài tập Toán', 'deadline': '20/10/2024', 'icon': Icons.book_outlined},
    {'title': 'Chuẩn bị thuyết trình Văn', 'deadline': '22/10/2024', 'icon': Icons.edit_outlined},
    {'title': 'Đăng ký giải bóng đá', 'deadline': '25/10/2024', 'icon': Icons.sports_soccer},
    {'title': 'Thí nghiệm Sinh học', 'deadline': '27/10/2024', 'icon': Icons.biotech_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Quản Lý Công Việc',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 20),
            child: Text(
              'Danh sách công việc',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
            ),
          ),
          Expanded(
            child: _tasks.isEmpty 
              ? _buildEmptyState() // Hiển thị khi hết việc
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    
                    // 🔥 KHẮC PHỤC LỖI GLOBAL KEY: Dùng Dismissible kèm ValueKey
                    return Dismissible(
                      key: ValueKey(task['title']), // ID duy nhất để Flutter không nhầm lẫn
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          _tasks.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đã xóa "${task['title']}"')),
                        );
                      },
                      background: _buildDeleteBackground(),
                      child: _buildTaskCard(task),
                    );
                  },
                ),
          ),
        ],
      ),
      
      // 🚀 NÚT THÊM CÔNG VIỆC GRADIENT
      floatingActionButton: _buildGradientFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(task['icon'], color: Colors.black87, size: 24),
        ),
        title: Text(
          task['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF111827)),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Hạn: ${task['deadline']}',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_turned_in_outlined, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          const Text('Tuyệt vời! Bạn đã hoàn thành hết việc.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildGradientFAB() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFFF64C75)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E2DE2).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Thêm công việc',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}