import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:classpal/core/constants/app_colors.dart';
import 'package:classpal/core/widgets/custom_button.dart';
import 'package:classpal/core/widgets/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Thông tin cá nhân', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            _buildTextFieldGroup('Họ và tên', 'Anh Tú'),
            _buildTextFieldGroup('Lớp', 'CNTT-1708'),
            _buildTextFieldGroup('Số điện thoại', '0987654321'),
            _buildTextFieldGroup('Email', 'anhtu@example.com'),
            
            const SizedBox(height: 30),
            CustomButton(text: 'Lưu thay đổi', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldGroup(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          CustomTextField(hintText: value), // In real app, pass controller with value
        ],
      ),
    );
  }
}
