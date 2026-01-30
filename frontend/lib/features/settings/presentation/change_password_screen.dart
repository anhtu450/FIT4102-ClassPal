import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:classpal/core/constants/app_colors.dart';
import 'package:classpal/core/widgets/custom_button.dart';
import 'package:classpal/core/widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Đổi mật khẩu', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CustomTextField(
              hintText: 'Mật khẩu hiện tại',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_off, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Mật khẩu mới',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_off, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Xác nhận mật khẩu mới',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_off, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 40),
            CustomButton(text: 'Cập nhật', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }
}
