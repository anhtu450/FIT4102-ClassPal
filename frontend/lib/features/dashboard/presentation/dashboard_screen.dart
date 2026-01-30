import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:classpal/core/constants/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder
                        backgroundColor: AppColors.lightGrey,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Lớp Trưởng 4.0', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          Text('Anh Tú - CNTT 17-08', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              const Text('Xin chào, Anh Tú  👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('Hôm nay bạn có 3 công việc cần lưu ý.', style: TextStyle(color: AppColors.textSecondary)),
              
              const SizedBox(height: 30),
              
              // Section: Hôm nay
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Hôm nay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(12)),
                        child: const Text('KHẨN CẤP', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const Text('Xem tất cả', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTodayCard(
                      icon: Icons.checklist,
                      iconColor: Colors.blue,
                      title: 'Báo cáo sĩ số sáng',
                      subtitle: 'Cần cập nhật trạng thái vắng học gửi GVCN',
                      deadline: 'Hết hạn: 8:00 AM',
                      progress: 0.7,
                      onTap: () => context.push('/task-detail', extra: {
                        'title': 'Báo cáo sĩ số sáng',
                        'subtitle': 'Cần cập nhật trạng thái vắng học gửi GVCN',
                        'deadline': 'Hết hạn: 8:00 AM',
                      }),
                    ),
                    const SizedBox(width: 15),
                    _buildTodayCard(
                      icon: Icons.book,
                      iconColor: Colors.orange,
                      title: 'Thu bài tập Toán',
                      subtitle: 'Hạn cuối nộp bài tập về nhà',
                      deadline: 'Hết hạn: 9:00 AM',
                      progress: 0.3,
                      onTap: () => context.push('/task-detail', extra: {
                        'title': 'Thu bài tập Toán',
                        'subtitle': 'Hạn cuối nộp bài tập về nhà',
                        'deadline': 'Hết hạn: 9:00 AM',
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Section: Quản lý lớp học
              const Text('Quản lý lớp học', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.4,
                children: [
                  _buildMenuCard(
                    icon: Icons.cleaning_services, 
                    color: Colors.blue[100]!, 
                    iconColor: Colors.blue, 
                    title: 'Trực nhật', 
                    subtitle: 'Hôm nay: Tổ 3',
                    onTap: () => context.push('/duty-roster'),
                  ),
                  _buildMenuCard(
                    icon: Icons.inventory_2, 
                    color: Colors.green[100]!, 
                    iconColor: Colors.green, 
                    title: 'Tài sản', 
                    subtitle: '40 bàn, 1 TV',
                    onTap: () => context.push('/asset-manager'),
                  ),
                  _buildMenuCard(
                    icon: Icons.event, 
                    color: Colors.pink[100]!, 
                    iconColor: Colors.pink, 
                    title: 'Sự kiện', 
                    subtitle: '26/3 Hội Trại',
                    onTap: () => context.push('/event-signup'),
                  ),
                  _buildMenuCard(
                    icon: Icons.account_balance_wallet, 
                    color: Colors.orange[100]!, 
                    iconColor: Colors.orange, 
                    title: 'Quỹ lớp', 
                    subtitle: 'Số dư: 2.500k',
                    onTap: () => context.push('/class-fund'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Section: Thông báo mới
              const Text('Thông báo mới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildNotificationItem(
                  'Cô Hoa (GVCN)',
                  'Đừng quên nhắc các bạn hoàn thành bài tập về nhà môn Toán trước 10h đêm nay nhé.',
                  '10p trước',
                  'https://i.pravatar.cc/150?img=5',
                  onTap: () => context.push('/notification-detail', extra: {
                    'name': 'Cô Hoa (GVCN)',
                    'content': 'Đừng quên nhắc các bạn hoàn thành bài tập về nhà môn Toán trước 10h đêm nay nhé.',
                    'time': '10p trước',
                    'avatarUrl': 'https://i.pravatar.cc/150?img=5'
                  })
              ),
              const SizedBox(height: 15),
              _buildNotificationItem(
                  'Đoàn Trường',
                  'Mẫu đăng ký thi văn nghệ 20/11 đã được cập nhật. Hạn chót đăng ký là thứ Sáu.',
                  '2h trước',
                  null, 
                  isSystem: true,
                  onTap: () => context.push('/notification-detail', extra: {
                    'name': 'Đoàn Trường',
                    'content': 'Mẫu đăng ký thi văn nghệ 20/11 đã được cập nhật. Hạn chót đăng ký là thứ Sáu.',
                    'time': '2h trước',
                    'avatarUrl': null
                  })
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home, label: 'Trang chủ', color: AppColors.primary, onTap: () {}),
              _buildNavItem(icon: Icons.calendar_today, label: 'Lịch', color: AppColors.grey, onTap: () {}),
              const SizedBox(width: 40), // Space for FAB
              _buildNavItem(icon: Icons.people, label: 'Thành viên', color: AppColors.grey, onTap: () {}),
              _buildNavItem(
                icon: Icons.settings, 
                label: 'Cài đặt', 
                color: AppColors.grey, 
                onTap: () => context.push('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String deadline,
    required double progress,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Text(deadline, style: const TextStyle(fontSize: 12, color: AppColors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress, backgroundColor: AppColors.lightGrey, color: AppColors.primary, minHeight: 4, borderRadius: BorderRadius.circular(2)),
        ],
      ),
    ));
  }

  Widget _buildMenuCard({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.3), shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String name, String content, String time, String? avatarUrl, {bool isSystem = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isSystem)
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(color: Colors.blue[50], shape: BoxShape.circle),
              child: const Icon(Icons.campaign, color: Colors.blue),
            )
          else
            CircleAvatar(radius: 25, backgroundImage: NetworkImage(avatarUrl!)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(content, style: const TextStyle(color: AppColors.textPrimary, height: 1.4)),
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildNavItem({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
