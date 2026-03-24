// Đường dẫn: lib/screens/register_screen.dart

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/app_session.dart';
import '../services/api_service.dart'; // 🔥 Import "tổng đài" API

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  bool _isLoading = false; 
  
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final Color primaryOrange = const Color(0xFFF05123);

  // 🔥 HÀM XỬ LÝ ĐĂNG KÝ THẬT: GỬI DỮ LIỆU LÊN SQL SERVER
  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final studentId = _idController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // 1. Kiểm tra nhập liệu
    if (name.isEmpty || studentId.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar('Vui lòng điền đủ thông tin để ClassPal nhận diện bạn!', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    // 2. TẠO OBJECT USER MỚI
    final newUser = UserModel(
      id: 0, // Backend SQL sẽ tự sinh ID này
      studentId: studentId,
      name: name,
      email: email,
      role: 'student', // Mặc định đăng ký mới là sinh viên
      school: 'Đại học Đại Nam',
    );

    // 3. GỌI API GỬI LÊN BACKEND .NET 9
    bool isSuccess = await ApiService.registerUser(newUser);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (isSuccess) {
      // Cập nhật vào danh sách local (tùy chọn)
      AppSession.registerNewStudent(newUser);

      _showSnackBar('Chúc mừng $name! Đăng ký thành công.', Colors.green);

      // 🚀 QUAY LẠI TRANG ĐĂNG NHẬP
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      _showSnackBar('Đăng ký thất bại! Có thể MSSV đã tồn tại hoặc lỗi server.', Colors.red);
    }
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tạo tài khoản', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Tham gia ClassPal', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF111827))),
              const SizedBox(height: 8),
              Text('Khởi tạo hồ sơ sinh viên của bạn ngay bây giờ.', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
              const SizedBox(height: 40),

              _buildInputLabel('Họ và tên'),
              _buildTextField(_nameController, 'Ví dụ: Nguyễn Minh Tú', Icons.person_outline),
              
              const SizedBox(height: 20),
              _buildInputLabel('Mã sinh viên'),
              _buildTextField(_idController, '22010101', Icons.badge_outlined),
              
              const SizedBox(height: 20),
              _buildInputLabel('Email sinh viên'),
              _buildTextField(_emailController, 'name@student.edu.vn', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              
              const SizedBox(height: 20),
              _buildInputLabel('Mật khẩu'),
              _buildPasswordField(),

              const SizedBox(height: 40),

              // NÚT ĐĂNG KÝ GRADIENT CAM (Đã xử lý chặn khi đang load)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isLoading ? [Colors.grey, Colors.grey] : [primaryOrange, const Color(0xFFFF8C00)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (!_isLoading) BoxShadow(color: primaryOrange.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Đăng ký tài khoản', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bạn đã có tài khoản? ', style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: Text('Đăng nhập', style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS (GIỮ NGUYÊN UI ĐẸP CỦA SẾP) ---
  Widget _buildInputLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0, left: 4),
    child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
  );

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF0F2F5),
        prefixIcon: Icon(icon, size: 20, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primaryOrange, width: 1.5)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Nhập mật khẩu',
        filled: true,
        fillColor: const Color(0xFFF0F2F5),
        prefixIcon: const Icon(Icons.lock_outline, size: 20, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, size: 20, color: Colors.grey),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primaryOrange, width: 1.5)),
      ),
    );
  }
}