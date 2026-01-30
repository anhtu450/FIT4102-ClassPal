import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:classpal/core/constants/app_colors.dart';
import 'package:classpal/core/widgets/custom_button.dart';
import 'package:classpal/core/widgets/custom_text_field.dart';
import '../dashboard/presentation/dashboard_screen.dart'; // Import Dashboard

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true; // State to switch between Login and Register

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Icon Top
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: const Icon(Icons.school, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: 30),
              
              // Title
              const Text(
                'Xin chào!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Đăng nhập để quản lý lớp học của bạn.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 30),

              // Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isLogin ? AppColors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                    )
                                  ]
                                : [],
                          ),
                          child: Text(
                            'Đăng nhập',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isLogin ? AppColors.primary : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isLogin ? AppColors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: !isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 5,
                                    )
                                  ]
                                : [],
                          ),
                          child: Text(
                            'Đăng ký',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !isLogin ? AppColors.primary : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Form
              if (!isLogin) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Họ và tên', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                const CustomTextField(
                  hintText: 'Nhập họ tên...',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
              ],

              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Email hoặc số điện thoại', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 8),
              const CustomTextField(
                hintText: 'nhập email...',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Mật khẩu', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 8),
              const CustomTextField(
                hintText: '********',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                suffixIcon: Icon(Icons.visibility_outlined, color: AppColors.textSecondary),
              ),

              if (!isLogin) ...[
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Xác nhận mật khẩu', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 8),
                const CustomTextField(
                  hintText: '********',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  suffixIcon: Icon(Icons.visibility_outlined, color: AppColors.textSecondary),
                ),
              ],
              
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Quên mật khẩu?', style: TextStyle(color: AppColors.primary)),
                ),
              ),
              
              const SizedBox(height: 10),
              CustomButton(
                text: isLogin ? 'Đăng nhập' : 'Đăng ký',
                onPressed: () {
                  // Navigate to Dashboard
                  context.go('/dashboard');
                },
              ),

              const SizedBox(height: 30),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('HOẶC TIẾP TỤC VỚI', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              
              // Google Button (Simulated)
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon placeholder
                    const Icon(Icons.g_mobiledata, size: 30, color: Colors.blue), // Replace with asset later
                    const SizedBox(width: 8),
                    const Text('Tiếp tục với Google', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bạn chưa có tài khoản? ', style: TextStyle(color: AppColors.textSecondary)),
                  GestureDetector(
                    onTap: () => setState(() => isLogin = false),
                    child: const Text('Đăng ký ngay', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
