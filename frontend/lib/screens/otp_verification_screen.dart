import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context), // 🔥 Đã fix: Quay lại trang đăng ký
        ),
        title: const Text(
          'Xác thực tài khoản',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Icon minh họa cho xịn
              const Icon(Icons.mark_email_read_outlined, size: 80, color: Color(0xFF00E5FF)),
              const SizedBox(height: 24),
              const Text(
                'Nhập mã xác thực',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Một mã OTP gồm 4 chữ số đã được gửi đến thiết bị của bạn. Vui lòng kiểm tra.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 🔢 CỤM 4 Ô NHẬP OTP (Tự vẽ trực tiếp)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOtpBox(context, first: true, last: false),
                  _buildOtpBox(context, first: false, last: false),
                  _buildOtpBox(context, first: false, last: false),
                  _buildOtpBox(context, first: false, last: true),
                ],
              ),

              const SizedBox(height: 40),

              // NÚT XÁC MINH
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Hiện thông báo thành công
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🎉 Xác thực thành công! Đang chuyển đến Đăng nhập...'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Chuyển sang trang Login
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'Xác minh',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // GỬI LẠI MÃ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bạn chưa nhận được mã? ', style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Gửi lại (29s)',
                      style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              
              TextButton(
                onPressed: () {},
                child: const Text('Cần trợ giúp?', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET TẠO Ô NHẬP OTP RIÊNG BIỆT
  Widget _buildOtpBox(BuildContext context, {required bool first, last}) {
    return Container(
      height: 70,
      width: 65,
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus(); // Tự nhảy sang ô tiếp theo
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus(); // Tự lùi lại khi xóa
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Color(0xFF00E5FF)),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}