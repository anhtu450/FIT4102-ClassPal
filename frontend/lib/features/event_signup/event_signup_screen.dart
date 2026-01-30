import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:classpal/core/constants/app_colors.dart';

class EventSignupScreen extends StatelessWidget {
  const EventSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Đăng Ký Sự Kiện', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.event, size: 60, color: AppColors.grey),
             SizedBox(height: 16),
             Text('Chức năng Sự Kiện (FR3)', style: TextStyle(fontSize: 18, color: AppColors.textSecondary)),
             Text('Đang phát triển...', style: TextStyle(fontSize: 14, color: AppColors.grey)),
          ],
        ),
      ),
    );
  }
}
