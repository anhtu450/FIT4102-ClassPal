// Đường dẫn: lib/screens/add_transaction_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_session.dart';

class AddTransactionScreen extends StatefulWidget {
  final bool isIncome; 
  const AddTransactionScreen({super.key, required this.isIncome});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _handleSave() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    // 🔥 Gọi "bộ não" AppSession để tính toán
    AppSession.addTransaction(
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      isIncome: widget.isIncome,
      subtitle: widget.isIncome ? 'Thu quỹ lớp' : 'Chi phí lớp',
    );

    Navigator.pop(context, true); // Trả về true để báo là đã lưu xong
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isIncome ? 'Thu quỹ' : 'Chi phí')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Nội dung')),
            const SizedBox(height: 20),
            TextField(controller: _amountController, decoration: const InputDecoration(labelText: 'Số tiền'), keyboardType: TextInputType.number),
            const Spacer(),
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(backgroundColor: widget.isIncome ? Colors.green : const Color(0xFFF05123)),
              child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}