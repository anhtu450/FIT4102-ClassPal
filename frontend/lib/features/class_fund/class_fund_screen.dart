import 'package:flutter/material.dart';

class ClassFundScreen extends StatelessWidget {
  const ClassFundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quỹ Lớp')),
      body: const Center(
        child: Text('Chức năng Quỹ Lớp (FR4) đang phát triển'),
      ),
    );
  }
}
