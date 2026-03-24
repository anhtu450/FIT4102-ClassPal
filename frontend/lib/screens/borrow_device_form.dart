// Đường dẫn: lib/screens/borrow_device_form.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Đừng quên thêm intl vào pubspec.yaml nhé
import '../utils/app_session.dart';

class BorrowDeviceForm extends StatefulWidget {
  const BorrowDeviceForm({super.key});

  @override
  State<BorrowDeviceForm> createState() => _BorrowDeviceFormState();
}

class _BorrowDeviceFormState extends State<BorrowDeviceForm> {
  final _nameController = TextEditingController();
  final _purposeController = TextEditingController();
  DateTime? _selectedDate;

  // Màu sắc theo thiết kế trong ảnh
  final Color primaryBlue = const Color(0xFF1CB5E0);
  final Color primaryPurple = const Color(0xFF8E54E9);
  final Color textGrey = const Color(0xFF9CA3AF);

  @override
  void initState() {
    super.initState();
    // Tự động điền tên người mượn từ Session
    _nameController.text = AppSession.currentUser?.name ?? "";
  }

  // Hàm chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleConfirm() {
    if (_nameController.text.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
      );
      return;
    }

    // 🔥 LOGIC: Lưu vào lịch sử tài sản
    AppSession.assetLogs.insert(0, {
      'status': 'Đang mượn',
      'name': _nameController.text,
      'item': 'Máy chiếu Epson EB-X06',
      'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'color': 'orange',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Gửi yêu cầu thành công!'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Yêu cầu mượn thiết bị', style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('THÔNG TIN THIẾT BỊ'),
            _buildDeviceCard(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('CHI TIẾT MƯỢN'),
            
            _buildInputLabel('Họ và tên người mượn'),
            _buildTextField(
              controller: _nameController,
              hint: 'Nhập tên đầy đủ của bạn',
              icon: Icons.person_outline,
            ),
            
            const SizedBox(height: 20),
            _buildInputLabel('Ngày trả dự kiến'),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: _buildDateDropdown(),
            ),
            
            const SizedBox(height: 20),
            _buildInputLabel('Mục đích sử dụng'),
            _buildTextField(
              controller: _purposeController,
              hint: 'Ví dụ: Giảng dạy lớp 10A2 tiết 3-4',
              icon: Icons.description_outlined,
              maxLines: 4,
            ),
            
            const SizedBox(height: 40),
            _buildGradientButton(),
            
            const SizedBox(height: 16),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Bằng cách nhấn xác nhận, bạn đồng ý chịu trách nhiệm bảo quản thiết bị này.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: TextStyle(color: textGrey, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.1)),
    );
  }

  Widget _buildDeviceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Ảnh thiết bị bo góc
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://vinhnam.com.vn/wp-content/uploads/2021/01/may-chieu-epson-eb-x06.jpg', // Ảnh minh họa
              width: 80, height: 80, fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Đã chọn', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 6),
                const Text('Máy chiếu Epson EB-X06', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Mã tài sản: CP-PRJ-001', style: TextStyle(color: textGrey, fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF374151))),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hint, required IconData icon, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: textGrey, size: 22),
        hintText: hint,
        hintStyle: TextStyle(color: textGrey.withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade100)),
      ),
    );
  }

  Widget _buildDateDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_month_outlined, color: textGrey, size: 22),
          const SizedBox(width: 12),
          Text(
            _selectedDate == null ? 'mm/dd/yyyy' : DateFormat('MM/dd/yyyy').format(_selectedDate!),
            style: TextStyle(color: _selectedDate == null ? textGrey.withOpacity(0.6) : Colors.black87, fontSize: 16),
          ),
          const Spacer(),
          Icon(Icons.calendar_today_outlined, color: textGrey, size: 18),
        ],
      ),
    );
  }

  Widget _buildGradientButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [primaryBlue, primaryPurple], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: primaryPurple.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: ElevatedButton(
        onPressed: _handleConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Xác nhận mượn', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(width: 12),
            Icon(Icons.send_rounded, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }
}