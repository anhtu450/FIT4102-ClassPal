import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- 1. IMPORT CƠ BẢN & XÁC THỰC ---
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/otp_verification_screen.dart';
import 'screens/profile_screen.dart'; 

// --- 2. HỆ THỐNG TRANG CHỦ ---
import 'screens/main_screen.dart'; 
import 'screens/admin_home_screen.dart';
import 'screens/student_home_screen.dart';

// --- 3. MODULE QUẢN LÝ TÁC VỤ & LỊCH (FR1) ---
import 'screens/task_list_v1_screen.dart'; 
import 'screens/calendar_screen.dart';
import 'screens/duty_schedule_screen.dart';
import 'screens/reminder_screen.dart';

// --- 4. MODULE TÀI CHÍNH & XẾP HẠNG (FR4) ---
import 'screens/finance_report_screen.dart';
import 'screens/expense_log_screen.dart';
import 'screens/fund_details_chart_screen.dart';
import 'screens/leaderboard_screen.dart';

// --- 5. MODULE TÀI SẢN (FR2) ---
import 'screens/asset_management_screen.dart';
import 'screens/asset_history_screen.dart'; 
import 'screens/borrow_device_form.dart'; 

// --- 6. MODULE SỰ KIỆN (FR3) ---
import 'screens/event_list_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/event_admin_dashboard_screen.dart';
import 'screens/add_event_screen.dart'; // 🔥 Đã thêm mảnh ghép mới

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 📱 Cấu hình hệ thống: Thanh trạng thái trong suốt & Chế độ màn hình đứng
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  
  runApp(const ClassPalApp());
}

class ClassPalApp extends StatelessWidget {
  const ClassPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFF05123);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClassPal',
      
      // 🎨 THEME ĐỒNG BỘ THƯƠNG HIỆU CLASSPAL
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryOrange,
          primary: primaryOrange,
          secondary: const Color(0xFFFF8C00),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', 

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 22),
          titleTextStyle: TextStyle(
            color: Color(0xFF111827), 
            fontSize: 20, 
            fontWeight: FontWeight.w900
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryOrange,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primaryOrange,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),

      initialRoute: '/welcome',

      // 🗺️ BẢN ĐỒ ĐIỀU HƯỚNG (ROUTES)
      routes: {
        // Cụm khởi đầu
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/otp_verification': (context) => const OtpVerificationScreen(),
        
        // Cụm trang chủ
        '/main_screen': (context) => const MainScreen(), 
        '/admin_home': (context) => const AdminHomeScreen(),
        '/student_home': (context) => const StudentHomeScreen(),
        
        // Module Quản lý & Nhiệm vụ
        '/task_list': (context) => const TaskListScreen(), 
        '/calendar': (context) => const CalendarScreen(),
        '/duty_schedule': (context) => const DutyScheduleScreen(),
        '/reminder': (context) => const ReminderScreen(),
        
        // Module Tài chính & Cộng đồng
        '/finance_report': (context) => const FinanceReportScreen(),
        '/expense_log': (context) => const ExpenseLogScreen(),
        '/fund_details': (context) => const FundDetailsChartScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        
        // Module Tài sản
        '/asset_management': (context) => const AssetManagementScreen(),
        '/asset_history': (context) => const AssetHistoryScreen(),
        '/borrow_device': (context) => const BorrowDeviceForm(), 
        
        // 🔥 MODULE SỰ KIỆN (FR3)
        '/event_list': (context) => const EventListScreen(),
        '/event_detail': (context) => const EventDetailScreen(),
        '/event_admin_dashboard': (context) => const EventAdminDashboardScreen(),
        '/add_event': (context) => const AddEventScreen(), // Link đến màn hình tạo mới

        '/profile': (context) => const ProfileScreen(),
      },

      // Xử lý khi Navigator gọi nhầm tên route
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Ops!')),
            body: const Center(child: Text('Trang này đang được nâng cấp!')),
          ),
        );
      },
    );
  }
}