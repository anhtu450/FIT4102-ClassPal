import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controller để lấy dữ liệu từ các ô nhập
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // Giá trị mặc định cho Status
  String _selectedStatus = 'MỚI';
  final List<String> _statusOptions = ['MỚI', 'HOT', 'SẮP DIỄN RA', 'BẮT BUỘC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tạo Sự Kiện Mới', style: TextStyle(fontWeight: FontWeight.w900)),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Thông tin cơ bản'),
              const SizedBox(height: 16),
              _buildTextField(_titleController, 'Tên sự kiện', Icons.event_note_rounded, 'Ví dụ: Hội thảo IT Đại Nam'),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(child: _buildDatePicker(context)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatusPicker()),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField(_locationController, 'Địa điểm', Icons.location_on_rounded, 'Ví dụ: Hội trường G'),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Mô tả chi tiết'),
              const SizedBox(height: 16),
              _buildTextField(_descController, 'Nội dung sự kiện', Icons.description_rounded, 'Nhập chi tiết chương trình...', maxLines: 4),
              
              const SizedBox(height: 40),
              
              // NÚT LƯU (SUBMIT)
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFE91E63), Color(0xFFF05123)]),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: _submitForm,
                  child: const Text('PHÁT HÀNH SỰ KIỆN', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HỖ TRỢ BUILD FORM ---
  
  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1));
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String hint, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFFF05123)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        floatingLabelStyle: const TextStyle(color: Color(0xFFF05123)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFF05123)), borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) => value!.isEmpty ? 'Vui lòng không để trống' : null,
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Ngày tổ chức',
        prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFFF05123)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          setState(() => _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate));
        }
      },
    );
  }

  Widget _buildStatusPicker() {
    return DropdownButtonFormField<String>(
      value: _selectedStatus,
      decoration: InputDecoration(
        labelText: 'Trạng thái',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      items: _statusOptions.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13)))).toList(),
      onChanged: (val) => setState(() => _selectedStatus = val!),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Demo logic: Sau này chỗ này sẽ gọi API POST lên ASP.NET
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🚀 Đang gửi dữ liệu lên Server...'), backgroundColor: Colors.blue),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context); // Quay lại trang trước
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Đã tạo sự kiện thành công!'), backgroundColor: Colors.green),
        );
      });
    }
  }
}