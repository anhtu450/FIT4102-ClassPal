// Đường dẫn: lib/screens/expense_log_screen.dart

import 'package:flutter/material.dart';

class ExpenseLogScreen extends StatefulWidget {
  const ExpenseLogScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseLogScreen> createState() => _ExpenseLogScreenState();
}

class _ExpenseLogScreenState extends State<ExpenseLogScreen> {
  // Màu chủ đạo theo Theme
  final Color primaryOrange = const Color(0xFFF05123);
  final Color successGreen = const Color(0xFF10B981);

  // 🔥 Dữ liệu mô phỏng đã được cấu trúc lại để chia nhóm theo Ngày
  final List<Map<String, dynamic>> _listItems = [
    {'isHeader': true, 'title': 'HÔM NAY', 'date': '15/10/2023'},
    {
      'isHeader': false,
      'title': 'Học phí học kỳ I',
      'subtitle': 'Lớp 12A1 • Chuyển khoản',
      'amount': '-2.500.000đ',
      'isIncome': false,
      'icon': Icons.receipt_long_rounded,
      'iconColor': Colors.blueGrey.shade600,
      'bgColor': Colors.blueGrey.shade50,
    },
    {
      'isHeader': false,
      'title': 'Đóng quỹ lớp',
      'subtitle': 'Nguyễn Văn An • Tiền mặt',
      'amount': '+500.000đ',
      'isIncome': true,
      'icon': Icons.payments_rounded,
      'iconColor': const Color(0xFFF05123), // Cam
      'bgColor': const Color(0xFFF05123).withOpacity(0.1),
    },
    {'isHeader': true, 'title': 'HÔM QUA', 'date': '14/10/2023'},
    {
      'isHeader': false,
      'title': 'Mua dụng cụ học tập',
      'subtitle': 'Nhà sách Fahasa • Tiền mặt',
      'amount': '-420.000đ',
      'isIncome': false,
      'icon': Icons.description_rounded,
      'iconColor': Colors.blueGrey.shade600,
      'bgColor': Colors.blueGrey.shade50,
    },
    {
      'isHeader': false,
      'title': 'Nước uống & Bánh ngọt',
      'subtitle': 'Tiệc trà chiều • Ví MoMo',
      'amount': '-185.000đ',
      'isIncome': false,
      'icon': Icons.shopping_basket_rounded,
      'iconColor': Colors.blueGrey.shade600,
      'bgColor': Colors.blueGrey.shade50,
    },
    {'isHeader': true, 'title': '12 THÁNG 10', 'date': ''},
    {
      'isHeader': false,
      'title': 'Phí đồng phục bổ sung',
      'subtitle': 'Lê Thị Bưởi • Chuyển khoản',
      'amount': '+1.200.000đ',
      'isIncome': true,
      'icon': Icons.account_balance_wallet_rounded,
      'iconColor': const Color(0xFFF05123),
      'bgColor': const Color(0xFFF05123).withOpacity(0.1),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Đổi màu nền về trắng hoàn toàn theo Design
      appBar: AppBar(
        title: const Text(
          'Nhật ký chi tiêu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Bỏ bóng đổ ở AppBar
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tìm kiếm giao dịch')));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // 💰 BẢNG TỔNG KẾT THU CHI
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                _buildTotalCard('TỔNG THU', '+15.200.000đ', successGreen),
                const SizedBox(width: 12),
                _buildTotalCard('TỔNG CHI', '-8.450.000đ', Colors.black87),
              ],
            ),
          ),

          // 📜 DANH SÁCH GIAO DỊCH NHÓM THEO NGÀY
          Expanded(
            child: ListView.builder(
              itemCount: _listItems.length,
              itemBuilder: (context, index) {
                final item = _listItems[index];

                // Nếu là Header (Ngày tháng)
                if (item['isHeader'] == true) {
                  return _buildHeader(item['title'], item['date']);
                }

                // Nếu là Item Giao dịch
                // Kiểm tra xem item tiếp theo có phải là Header không để quyết định ẩn/hiện đường kẻ mờ (Divider)
                bool isLastInGroup = (index == _listItems.length - 1) || (_listItems[index + 1]['isHeader'] == true);

                return _buildTransactionItem(item, showDivider: !isLastInGroup);
              },
            ),
          ),
        ],
      ),

      // 🔥 NÚT (+) CAM ĐỂ THÊM GIAO DỊCH
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryOrange,
        elevation: 4,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mở form nhập thu/chi')));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),

      // 🧭 ĐÃ XÓA SẠCH BOTTOM NAVIGATION BAR THEO CHIẾN THUẬT "GOM TAB"
    );
  }

  // --- CÁC WIDGET THÀNH PHẦN ---

  // Thẻ Tổng thu / Tổng chi
  Widget _buildTotalCard(String title, String amount, Color amountColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100, width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(color: amountColor, fontSize: 18, fontWeight: FontWeight.w900),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Tiêu đề Ngày tháng (HÔM NAY, HÔM QUA...)
  Widget _buildHeader(String title, String date) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1.2, color: Colors.black87),
          ),
          if (date.isNotEmpty)
            Text(
              date,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }

  // Dòng hiển thị từng giao dịch
  Widget _buildTransactionItem(Map<String, dynamic> item, {required bool showDivider}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Cục Icon bo góc
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item['bgColor'],
                  borderRadius: BorderRadius.circular(14), // Bo góc vuông như Design
                ),
                child: Icon(item['icon'], color: item['iconColor'], size: 24),
              ),
              const SizedBox(width: 16),
              
              // Thông tin giao dịch
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['subtitle'],
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              
              // Số tiền
              Text(
                item['amount'],
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: item['isIncome'] ? successGreen : Colors.black87, // Đen cho tiền ra, Xanh cho tiền vào
                ),
              ),
            ],
          ),
        ),
        // Đường kẻ mờ phân cách giữa các item trong cùng 1 ngày
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 76, right: 20), // Thụt lề cho đường kẻ nhìn chuyên nghiệp hơn
            child: Divider(height: 1, thickness: 1, color: Colors.grey.shade100),
          ),
      ],
    );
  }
}