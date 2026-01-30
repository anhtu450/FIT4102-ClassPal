import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/constants/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Đăng nhập ClassPal'),
              const SizedBox(height: 20),
              // Add form fields here
              CustomButton(
                text: 'Đăng nhập',
                onPressed: () {
                  // Handle login logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
