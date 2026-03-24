// Đường dẫn: lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_session.dart';
// ignore: unused_import
import '../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isStudentLogin = true;
  bool isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Màu cam chủ đạo theo thiết kế ClassPal mới
  final Color primaryOrange = const Color(0xFFF05123);

  // 🔥 HÀM XỬ LÝ ĐĂNG NHẬP (FIX TRIỆT ĐỂ LỖI GẠCH ĐỎ & MẤT TAB)
  void _handleLogin() {
    String email = _emailController.text.trim().toLowerCase();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập Email!')),
      );
      return;
    }

    // Xác định vai trò dựa trên tab chọn hoặc nội dung email
    String assignedRole = (!isStudentLogin || email.contains('admin')) ? 'admin' : 'student';

    // 1. XỬ LÝ DỮ LIỆU SESSION
    if (AppSession.currentUser == null) {
      // TRƯỜNG HỢP A: Tú chưa qua trang Đăng ký -> Dùng dữ liệu mẫu (Mock)
      AppSession.currentUser = (assignedRole == 'admin') 
          ? AppSession.mockAdmin 
          : AppSession.mockStudent;
    } else {
      // TRƯỜNG HỢP B: Tú đã Đăng ký (đã có tên thật) -> Chỉ cập nhật lại Role
      // Sử dụng copyWith để dứt điểm lỗi gạch đỏ (không sửa trực tiếp biến final)
      AppSession.currentUser = AppSession.currentUser!.copyWith(role: assignedRole);
    }

    // 2. ĐIỀU HƯỚNG VÀO CỬA CHÍNH /main_screen
    // Navigator.pushNamedAndRemoveUntil giúp xóa lịch sử trang Login
    // và mở MainScreen (nơi chứa thanh Tab Bar duy nhất)
    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/main_screen', 
      (route) => false, 
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Đăng nhập', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // --- TOGGLE CHỌN VAI TRÒ ---
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    children: [
                      _buildRoleTab('Sinh viên', true),
                      _buildRoleTab('Cán sự lớp', false),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Chào mừng quay lại!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sử dụng tài khoản ClassPal để tiếp tục',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // --- Ô NHẬP EMAIL ---
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'admin@gmail.com để test Admin',
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide(color: Colors.grey.shade100)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primaryOrange, width: 1.5)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                ),
                const SizedBox(height: 16),

                // --- Ô NHẬP MẬT KHẨU ---
                TextField(
                  controller: _passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide(color: Colors.grey.shade100)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primaryOrange, width: 1.5)),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Quên mật khẩu?', style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 32),

                // --- NÚT ĐĂNG NHẬP ---
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      shadowColor: primaryOrange.withOpacity(0.4),
                    ),
                    child: const Text(
                      'Đăng nhập ngay',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                _buildSocialLoginDivider(),
                const SizedBox(height: 24),
                _buildSocialButtons(),
                const SizedBox(height: 32),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget con: Tab chọn vai trò
  Widget _buildRoleTab(String label, bool isStudentTab) {
    bool isActive = isStudentLogin == isStudentTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isStudentLogin = isStudentTab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: isActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))] : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? primaryOrange : Colors.grey.shade500,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Text('HOẶC TIẾP TỤC VỚI', style: TextStyle(fontSize: 11, color: Colors.grey.shade400, fontWeight: FontWeight.bold, letterSpacing: 1))),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        _socialIcon(Icons.g_mobiledata_rounded, 'Google'),
        const SizedBox(width: 16),
        _socialIcon(Icons.chat_bubble_outline_rounded, 'Zalo'),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String label) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 24),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black87,
          side: BorderSide(color: Colors.grey.shade200),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Bạn mới biết đến ClassPal? ', style: TextStyle(color: Colors.grey)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/register'),
          child: Text('Tham gia ngay', style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}