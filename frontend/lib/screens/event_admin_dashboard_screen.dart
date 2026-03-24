import 'package:flutter/material.dart';

class EventAdminDashboardScreen extends StatelessWidget {
  const EventAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 📊 1. DỮ LIỆU THỰC TẾ (Sếp thêm bớt tên ở đây, số liệu Dashboard sẽ tự nhảy)
    const int totalStudents = 50;
    
    final List<String> registeredStudents = [
      'Nguyễn Minh Tú (LT)', 'Trần Thúy Hằng', 'Vũ Việt Anh', 'Đỗ Xuân Thắng', 
      'Lê Phương Thảo', 'Hoàng Bảo Long', 'Phạm Quỳnh Anh', 'Bùi Đức Mạnh',
      'Đặng Hoài Thu', 'Lương Minh Châu', 'Lý Hải Nam', 'Trịnh Cẩm Vân'
    ];

    final List<String> lazyStudents = [
      'Nguyễn Văn An', 'Trần Thị Bình', 'Phạm Đức Cường', 'Vũ Thị Dung',
      'Đặng Xuân Lợi', 'Lê Bích Phượng', 'Hoàng Văn Sơn', 'Nguyễn Phương Thảo (IT)'
    ];

    // 🧮 2. TỰ ĐỘNG TÍNH TOÁN LOGIC
    final int registeredCount = registeredStudents.length;
    final int lazyCount = lazyStudents.length;
    final double progress = registeredCount / totalStudents;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            const Text('Dashboard Quản lý', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Hội thảo Hướng nghiệp 2024', 
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          ],
        ),
      ),
      
      // Dùng Column trực tiếp để tránh lỗi xung đột cuộn của TabBarView
      body: Column(
        children: [
          // 📈 PHẦN THỐNG KÊ (CỐ ĐỊNH Ở TRÊN)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildStatDashboard(registeredCount, lazyCount, totalStudents, progress),
          ),

          // 📋 DANH SÁCH CHI TIẾT (CHIẾM PHẦN CÒN LẠI)
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100, 
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: const Color(0xFFF05123),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: 'Đã đăng ký ($registeredCount)'),
                          Tab(text: 'Lười ($lazyCount)'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildStudentList(context, registeredStudents, Colors.green),
                        _buildStudentList(context, lazyStudents, Colors.redAccent),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HÀM BUILD THỐNG KÊ ---
  Widget _buildStatDashboard(int reg, int lazy, int total, double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard(Icons.check_circle_outline, 'Đăng ký', reg, total, Colors.green),
              _buildStatCard(Icons.hourglass_empty, 'Chưa xong', lazy, total, Colors.redAccent),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF05123),
                ),
              ),
              const SizedBox(width: 12),
              Text('${(progress * 100).toInt()}%', 
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF05123))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, int val, int total, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text('$val/$total', 
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }

  // --- HÀM BUILD DANH SÁCH ---
  Widget _buildStudentList(BuildContext context, List<String> students, Color color) {
    return Column(
      children: [
        // Chỉ hiện nút "Nhắc nhở" bên Tab Lười
        if (color == Colors.redAccent)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hành động cán sự:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🔔 Đã gửi nhắc nhở đến các bạn chưa đăng ký!'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }, 
                  icon: const Icon(Icons.notifications_active, size: 16, color: Colors.red),
                  label: const Text('Gửi nhắc nhở', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: students.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB), 
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color.withOpacity(0.1),
                      child: Text(students[index][0], 
                        style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(students[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('DNU21DCN${100 + index}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade300),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}