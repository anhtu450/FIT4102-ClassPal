// Đường dẫn: lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_session.dart';

// --- IMPORT CÁC TRANG CON ---
import 'admin_home_screen.dart'; 
import 'student_home_screen.dart';
import 'task_list_v1_screen.dart';     
import 'asset_management_screen.dart'; 
import 'leaderboard_screen.dart';       // Trang Xếp hạng
import 'event_list_screen.dart';       // Trang Sự kiện
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; 
  final Color primaryOrange = const Color(0xFFF05123);

  @override
  Widget build(BuildContext context) {
    // 1. Kiểm tra quyền từ Session
    final user = AppSession.currentUser ?? AppSession.mockStudent;
    final bool isAdmin = user.role == 'admin';

    // 2. Định nghĩa danh sách màn hình theo vai trò
    // Dành cho SINH VIÊN (5 Tab theo yêu cầu mới)
    final List<Widget> studentScreens = [
      const StudentHomeScreen(),    // Tab 0
      const AssetManagementScreen(),   // Tab 1: Tài sản
      const EventListScreen(),      // Tab 2: Sự kiện
      const LeaderboardScreen(),    // Tab 3: Xếp hạng
      const ProfileScreen(),        // Tab 4
    ];

    // Dành cho ADMIN (Giữ nguyên 4 Tab quản lý)
    final List<Widget> adminScreens = [
      const AdminHomeScreen(),      // Tab 0
      const TaskListScreen(),       // Tab 1
      const AssetManagementScreen(),// Tab 2
      const ProfileScreen(),        // Tab 3
    ];

    // Chọn danh sách màn hình và danh sách Tab Items tương ứng
    List<Widget> currentScreens = isAdmin ? adminScreens : studentScreens;
    List<BottomNavigationBarItem> navItems = isAdmin ? _adminNavItems() : _studentNavItems();

    return Scaffold(
      // IndexedStack: Giữ trạng thái trang, không bị load lại khi chuyển tab
      body: IndexedStack(
        index: _selectedIndex,
        children: currentScreens,
      ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), 
              blurRadius: 10, 
              offset: const Offset(0, -2)
            )
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Quan trọng: Giữ icon đứng yên khi có 5 tab
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: primaryOrange,
          unselectedItemColor: Colors.grey.shade400,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: navItems,
        ),
      ),
    );
  }

  // --- HÀM TẠO ITEM CHO SINH VIÊN ---
  List<BottomNavigationBarItem> _studentNavItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), 
        activeIcon: Icon(Icons.home_filled),
        label: 'Trang chủ',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.inventory_2_outlined), 
        activeIcon: Icon(Icons.inventory_2),
        label: 'Tài sản',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event_note_outlined), 
        activeIcon: Icon(Icons.event_note),
        label: 'Sự kiện',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard_outlined), 
        activeIcon: Icon(Icons.leaderboard),
        label: 'Xếp hạng',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline), 
        activeIcon: Icon(Icons.person),
        label: 'Cá nhân',
      ),
    ];
  }

  // --- HÀM TẠO ITEM CHO ADMIN ---
  List<BottomNavigationBarItem> _adminNavItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), 
        activeIcon: Icon(Icons.home_filled),
        label: 'Trang chủ',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_outlined), 
        activeIcon: Icon(Icons.assignment),
        label: 'Nhiệm vụ',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.inventory_2_outlined), 
        activeIcon: Icon(Icons.inventory_2),
        label: 'Tài sản',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline), 
        activeIcon: Icon(Icons.person),
        label: 'Cá nhân',
      ),
    ];
  }
}