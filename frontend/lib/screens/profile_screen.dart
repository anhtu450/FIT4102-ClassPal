// Đường dẫn: lib/screens/profile_screen.dart

import 'package:flutter/material.dart';

// 🔥 IMPORT KHO DỮ LIỆU
import '../models/user_model.dart';
import '../utils/app_session.dart';

// -------------------------------------------------------------------
// 🔥 TRANG PROFILE ĐỘNG (ĐÃ KẾT NỐI SESSION)
// -------------------------------------------------------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 "MỞ KHO" LẤY DỮ LIỆU: Nếu không có ai đăng nhập thì lấy tạm mockStudent
    final UserModel user = AppSession.currentUser ?? AppSession.mockStudent;
    final bool isAdmin = user.role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Avatar Section
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: (isAdmin ? Colors.orange : const Color(0xFF00E5FF)).withOpacity(0.1),
                    child: Icon(
                      isAdmin ? Icons.admin_panel_settings : Icons.person, 
                      size: 80, 
                      color: isAdmin ? Colors.orange : const Color(0xFF00E5FF)
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: isAdmin ? Colors.orange : const Color(0xFF00E5FF),
                    child: const Icon(Icons.camera_alt, size: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 🔥 TÊN & CHỨC VỤ (Đã gắn dữ liệu động)
            Text(
              user.name, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
            ),
            Text(
              isAdmin ? 'Ban cán sự - CNTT K17' : 'Sinh viên - Công nghệ thông tin', 
              style: const TextStyle(color: Colors.grey)
            ),
            
            const SizedBox(height: 30),
            
            // 🔥 THÔNG TIN CHI TIẾT (Đã gắn dữ liệu động)
            _buildInfoTile(Icons.school_outlined, 'Trường', user.school),
            _buildInfoTile(
              Icons.badge_outlined, 
              isAdmin ? 'Mã quản trị' : 'Mã sinh viên', 
              user.studentId
            ),
            _buildInfoTile(Icons.email_outlined, 'Email', user.email ?? 'Chưa cập nhật'),
            _buildInfoTile(Icons.phone_android_outlined, 'Điện thoại', user.phone ?? 'Chưa cập nhật'),
            
            const SizedBox(height: 30),
            
            // NÚT ĐĂNG XUẤT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: OutlinedButton(
                onPressed: () {
                  // 🔥 DỌN SẠCH KHO: Xóa phiên đăng nhập
                  AppSession.clearSession();
                  
                  // 🔥 Về Login và xóa sạch lịch sử
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Đăng xuất', 
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: const Color(0xFF00E5FF)),
      ),
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
    );
  }
}