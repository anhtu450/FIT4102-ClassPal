// Đường dẫn: lib/utils/app_session.dart

import '../models/user_model.dart';

class AppSession {
  // 👤 Người dùng hiện tại (Lưu trong RAM)
  static UserModel? currentUser;

  // -------------------------------------------------------------------
  // 📦 DỮ LIỆU MẪU (MOCK DATA) - ĐÃ KHÔI PHỤC ĐẦY ĐỦ
  // -------------------------------------------------------------------
  
  static final UserModel mockAdmin = UserModel(
    id: 'ADM-21A100', 
    name: 'Admin Tú', 
    email: 'admin@dainam.edu.vn', 
    role: 'admin', 
    phone: '0988.111.222', 
    school: 'Đại học Đại Nam',
  );

  static final UserModel mockStudent = UserModel(
    id: '21A123456', 
    name: 'Trần Anh Tú', 
    email: 'anhtu@dainam.edu.vn', 
    role: 'student', 
    phone: '0912.345.678', 
    school: 'Đại học Đại Nam',
  );

  // -------------------------------------------------------------------
  // 💰 QUẢN LÝ TÀI CHÍNH (BỘ NÃO MỚI)
  // -------------------------------------------------------------------
  
  static double totalFund = 15250000; // Con số tổng quỹ

  static List<Map<String, dynamic>> expenseHistory = [
    {
      'title': 'Học phí học kỳ I',
      'subtitle': 'Lớp 12A1 • Chuyển khoản',
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

  // Hàm thêm giao dịch và tự nhảy số tiền
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

  // Hàm định dạng tiền tệ (15.250.000 đ)
  static String formatCurrency(double amount) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    return '${amount.toStringAsFixed(0).replaceAllMapped(reg, mathFunc)} đ';
  }

  // -------------------------------------------------------------------
  // 👥 QUẢN LÝ SINH VIÊN (DÙNG CHO LỜI NHẮC)
  // -------------------------------------------------------------------
  
  static List<UserModel> allStudents = [
    mockStudent,
    UserModel(id: '21A001', name: 'Nguyễn Văn An', email: 'an@dainam.edu.vn', role: 'student'),
    UserModel(id: '21A002', name: 'Trần Thị Bích', email: 'bich@dainam.edu.vn', role: 'student'),
    UserModel(id: '21A003', name: 'Lê Văn Cường', email: 'cuong@dainam.edu.vn', role: 'student'),
  ];

  static void registerNewStudent(UserModel user) {
    if (!allStudents.any((s) => s.id == user.id)) {
      allStudents.add(user);
    }
  }

  // -------------------------------------------------------------------
  // 📩 THÔNG BÁO & TÀI SẢN
  // -------------------------------------------------------------------
  
  static List<Map<String, String>> notifications = [
    {'title': 'THÔNG BÁO CHUNG', 'content': 'Chào mừng bạn đến với ClassPal!', 'time': '1 giờ trước'},
  ];

  static List<Map<String, String>> assetLogs = [
    {'status': 'Đã trả', 'name': 'Nguyễn Văn An', 'item': 'MacBook Pro M2', 'date': 'Hôm nay', 'color': 'green'},
  ];

  // 🧹 UTILS
  static bool get isAdmin => currentUser?.role == 'admin';

  static void clearSession() {
    currentUser = null;
  }
}