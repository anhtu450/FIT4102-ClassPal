import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  final Function(String)? onFilterChanged; // 🔥 Callback để báo cho màn hình cha biết đã chọn gì

  const FilterBar({Key? key, this.onFilterChanged}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  // 🔥 Biến lưu giá trị đang được chọn
  String _selectedValue = 'Tháng';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔽 DROPDOWN CHỌN THỜI GIAN
          DropdownButtonHideUnderline( // Ẩn cái gạch chân mặc định cho đẹp
            child: DropdownButton<String>(
              value: _selectedValue,
              icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF00E5FF)),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              items: ['Tháng', 'Tuần', 'Học kỳ', 'Năm học'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedValue = newValue; // 🔥 Cập nhật lại giao diện
                  });
                  if (widget.onFilterChanged != null) {
                    widget.onFilterChanged!(newValue); // Báo cho màn hình cha
                  }
                }
              },
            ),
          ),

          // 🔍 NÚT LỌC NÂNG CAO
          Row(
            children: [
              Text(
                'Lọc thêm',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.tune_rounded, color: Color(0xFF00E5FF), size: 22),
                onPressed: () {
                  // Mở BottomSheet hoặc Dialog để lọc sâu hơn
                  _showAdvancedFilter(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị BottomSheet lọc nâng cao
  void _showAdvancedFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Bộ lọc nâng cao', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              // Ở đây Tú có thể thêm các Chip hoặc Checkbox để lọc theo Loại giao dịch, Trạng thái...
              const Text('Loại giao dịch:', style: TextStyle(color: Colors.grey)),
              Wrap(
                spacing: 10,
                children: [
                  ChoiceChip(label: const Text('Tất cả'), selected: true, onSelected: (b){}),
                  ChoiceChip(label: const Text('Thu'), selected: false, onSelected: (b){}),
                  ChoiceChip(label: const Text('Chi'), selected: false, onSelected: (b){}),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}