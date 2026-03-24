// Đường dẫn: lib/utils/app_session.dart

import '../models/user_model.dart';

class AppSession {
  // 👤 Người dùng hiện tại (Lưu trong RAM sau khi API trả kết quả về)
  static UserModel? currentUser;

  // -------------------------------------------------------------------
  // 📦 DỮ LIỆU MẪU (MOCK DATA) - KHỚP 100% VỚI MODEL NAME & STUDENT_ID
  // -------------------------------------------------------------------
  
  static final UserModel mockAdmin = UserModel(
    id: 1, 
    studentId: 'ADM-21A100', 
    name: 'Admin Tú', 
    email: 'admin@dainam.edu.vn', 
    role: 'admin', 
    phone: '0988.111.222', 
    school: 'Đại học Đại Nam',
  );

  static final UserModel mockStudent = UserModel(
    id: 2, 
    studentId: '21A123456', 
    name: 'Trần Anh Tú', 
    email: 'anhtu@dainam.edu.vn', 
    role: 'student', 
    phone: '0912.345.678', 
    school: 'Đại học Đại Nam',
  );

  // -------------------------------------------------------------------
  // 💰 QUẢN LÝ TÀI CHÍNH (PHẦN NÀY ĐỂ HIỆN BIỂU ĐỒ FR4)
  // -------------------------------------------------------------------
  
  static double totalFund = 15250000; 

  static List<Map<String, dynamic>> expenseHistory = [
    {
      'title': 'Học phí học kỳ I',
      'subtitle': 'Lớp IT-K17 • Chuyển khoản',
      'amount': 2500000.0,
      'isIncome': false,
      'date': '20/03/2026',
    },
    {
      'title': 'Đóng quỹ lớp',
      'subtitle': 'Nguyễn Văn An • Tiền mặt',
      'amount': 500000.0,
      'isIncome': true,
      'date': '19/03/2026',
    },
  ];

  static void addTransaction({
    required String title,
    required double amount,
    required bool isIncome,
    String subtitle = 'Thao tác thủ công',
  }) {
    expenseHistory.insert(0, {
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'isIncome': isIncome,
      'date': 'Hôm nay',
    });

    if (isIncome) totalFund += amount;
    else totalFund -= amount;
  }

  // Tiện ích định dạng tiền tệ: 15.250.000 đ
  static String formatCurrency(double amount) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    return '${amount.toStringAsFixed(0).replaceAllMapped(reg, mathFunc)} đ';
  }

  // -------------------------------------------------------------------
  // 👥 QUẢN LÝ DANH SÁCH LỚP (DÙNG CHO LỜI NHẮC/GIAO VIỆC)
  // -------------------------------------------------------------------
  
  static List<UserModel> allStudents = [
    mockStudent,
    UserModel(id: 3, studentId: '21A001', name: 'Nguyễn Văn An', email: 'an@dainam.edu.vn', role: 'student'),
    UserModel(id: 4, studentId: '21A002', name: 'Trần Thị Bích', email: 'bich@dainam.edu.vn', role: 'student'),
    UserModel(id: 5, studentId: '21A003', name: 'Lê Văn Cường', email: 'cuong@dainam.edu.vn', role: 'student'),
  ];

  static void registerNewStudent(UserModel user) {
    // Luôn kiểm tra MSSV trước khi thêm để tránh trùng lặp 
    if (!allStudents.any((s) => s.studentId == user.studentId)) {
      allStudents.add(user);
    }
  }

  // -------------------------------------------------------------------
  // 📩 THÔNG BÁO & TÀI SẢN (FR2)
  // -------------------------------------------------------------------
  
  static List<Map<String, String>> notifications = [
    {'title': 'THÔNG BÁO CHUNG', 'content': 'Chào mừng bạn đến với ClassPal!', 'time': '1 giờ trước'},
  ];

  static List<Map<String, String>> assetLogs = [
    {'status': 'Đã trả', 'name': 'Nguyễn Văn An', 'item': 'MacBook Pro M2', 'date': 'Hôm nay', 'color': 'green'},
  ];

  // -------------------------------------------------------------------
  // 🧹 UTILS (TIỆN ÍCH HỆ THỐNG)
  // -------------------------------------------------------------------
  
  // Kiểm tra quyền Admin an toàn (không bị crash nếu chưa đăng nhập)
  // Sử dụng lowercase để so sánh cho chắc chắn
  static bool get isAdmin => currentUser?.role.toLowerCase() == 'admin';

  // Lấy tên hiển thị an toàn cho Header
  static String get currentUserName => currentUser?.name ?? "Khách";

  // Xóa sạch phiên làm việc khi người dùng nhấn "Đăng xuất"
  static void clearSession() {
    currentUser = null;
    // Có thể dọn dẹp thêm các cache khác ở đây nếu cần
  }
}