// Đường dẫn: lib/screens/task_list_v1_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/app_session.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<dynamic>> _tasksFuture;
  final Color primaryOrange = const Color(0xFFF05123);

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  // Hàm làm mới danh sách từ Backend
  void _refreshTasks() {
    setState(() {
      _tasksFuture = ApiService.getTasks();
    });
  }

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
        actions: [
          IconButton(
            onPressed: _refreshTasks,
            icon: const Icon(Icons.refresh, color: Colors.black),
          )
        ],
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
            child: FutureBuilder<List<dynamic>>(
              future: _tasksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(child: Text("Không thể kết nối với Backend sếp ơi!"));
                }

                // Lấy data và lọc (Nếu sếp muốn hiện tất cả thì bỏ .where đi)
                final tasks = snapshot.data!;

                if (tasks.isEmpty) return _buildEmptyState();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final taskId = task['id'];

                    return Dismissible(
                      key: ValueKey(taskId), // Dùng ID từ Database làm Key (Chuẩn bài!)
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        // Hỏi sếp trước khi xóa thật
                        return await _showDeleteConfirm(task['title']);
                      },
                      onDismissed: (direction) async {
                        bool deleted = await ApiService.deleteTask(taskId);
                        if (deleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã xóa "${task['title']}" khỏi Database')),
                          );
                        }
                      },
                      background: _buildDeleteBackground(),
                      child: _buildTaskCard(task),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildGradientFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isDone = task['isCompleted'] ?? false;

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
            color: isDone ? Colors.green.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            isDone ? Icons.check_circle : Icons.assignment_outlined, 
            color: isDone ? Colors.green : Colors.black87, 
            size: 24
          ),
        ),
        title: Text(
          task['title'] ?? 'Nhiệm vụ không tên',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 17, 
            color: const Color(0xFF111827),
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Người làm: ${task['assigneeName'] ?? "Chưa phân công"}',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: () {
          // TODO: Mở chi tiết công việc hoặc đánh dấu hoàn thành
        },
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("XÓA VĨNH VIỄN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Icon(Icons.delete_sweep_outlined, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt_rounded, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          const Text('Hiện không có công việc nào cần xử lý!', style: TextStyle(color: Colors.grey)),
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
        onTap: () {
          // TODO: Điều hướng đến trang thêm công việc
          _refreshTasks(); 
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_task_rounded, color: Colors.white),
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

  Future<bool?> _showDeleteConfirm(String title) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận xóa?"),
        content: Text("Sếp có chắc muốn xóa nhiệm vụ '$title' khỏi hệ thống không?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("HỦY")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("XÓA", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}