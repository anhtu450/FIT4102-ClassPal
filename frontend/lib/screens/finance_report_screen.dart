// Đường dẫn: lib/screens/finance_report_screen.dart

import 'package:flutter/material.dart';

class FinanceReportScreen extends StatefulWidget {
  const FinanceReportScreen({Key? key}) : super(key: key);

  @override
  State<FinanceReportScreen> createState() => _FinanceReportScreenState();
}

class _FinanceReportScreenState extends State<FinanceReportScreen> {
  // 0: Hàng tháng, 1: Hàng quý, 2: Hàng năm
  int _selectedPeriod = 0; 
  
  // Màu chủ đạo theo Theme mới
  final Color primaryOrange = const Color(0xFFF05123);
  final Color successGreen = const Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng toàn tập theo thiết kế
      appBar: AppBar(
        title: const Text(
          'Báo cáo tài chính',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chọn thời gian cụ thể')));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. THANH TAB CHỌN KỲ (Hàng tháng / Hàng quý / Hàng năm)
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
              ),
              child: Row(
                children: [
                  _buildPeriodTab('Hàng tháng', 0),
                  _buildPeriodTab('Hàng quý', 1),
                  _buildPeriodTab('Hàng năm', 2),
                ],
              ),
            ),
            
            // 2. KHỐI BIỂU ĐỒ (Dùng Text để mô phỏng trục X)
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade100, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tình hình quỹ hiện tại',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '45.000.000',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6, left: 4),
                        child: Text(
                          'đ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.trending_up_rounded, color: successGreen, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+12.5%',
                        style: TextStyle(color: successGreen, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'so với tháng trước',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      ),
                    ],
                  ),
                  
                  // Khu vực để trống giả lập biểu đồ đường (Khoảng trắng)
                  const SizedBox(height: 120),
                  
                  // Trục X của biểu đồ (Tháng 1 -> Tháng 6)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildChartLabel('T1', false),
                      _buildChartLabel('T2', false),
                      _buildChartLabel('T3', false),
                      _buildChartLabel('T4', false),
                      _buildChartLabel('T5', false),
                      _buildChartLabel('T6', true), // Tháng hiện tại nổi bật
                    ],
                  ),
                ],
              ),
            ),

            // 3. DANH SÁCH THẺ THỐNG KÊ CHI TIẾT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildStatCard(
                    icon: Icons.south_west_rounded,
                    iconBgColor: Colors.blue.shade50,
                    iconColor: Colors.blueAccent,
                    title: 'TỔNG THU NHẬP',
                    amount: '62.800.000',
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    icon: Icons.north_east_rounded,
                    iconBgColor: Colors.red.shade50,
                    iconColor: Colors.redAccent,
                    title: 'TỔNG CHI TIÊU',
                    amount: '17.800.000',
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    icon: Icons.account_balance_wallet_rounded,
                    iconBgColor: successGreen.withOpacity(0.1),
                    iconColor: successGreen,
                    title: 'SỐ DƯ RÒNG',
                    amount: '45.000.000',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4. NÚT XUẤT PDF CHUẨN DESIGN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đang xuất báo cáo ra file PDF...')));
                },
                icon: const Icon(Icons.picture_as_pdf_outlined, color: Color(0xFF111827)),
                label: const Text(
                  'Xuất PDF',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 54),
                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      
      // 🧭 ĐÃ XÓA SẠCH BOTTOM NAVIGATION BAR ĐỂ ĐỒNG BỘ "GOM TAB"
    );
  }

  // --- CÁC WIDGET THÀNH PHẦN ---

  // Tab chọn thời gian có gạch dưới màu cam
  Widget _buildPeriodTab(String title, int index) {
    bool isSelected = _selectedPeriod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriod = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryOrange : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? primaryOrange : Colors.grey.shade500,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Label cho trục X biểu đồ
  Widget _buildChartLabel(String text, bool isCurrent) {
    return Text(
      text,
      style: TextStyle(
        color: isCurrent ? primaryOrange : Colors.grey.shade400,
        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
        fontSize: 12,
      ),
    );
  }

  // Thẻ thống kê chi tiết (Tổng thu, Tổng chi...)
  Widget _buildStatCard({required IconData icon, required Color iconBgColor, required Color iconColor, required String title, required String amount}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // Nền xám khói cực nhạt theo thiết kế
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          // Vòng tròn chứa Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          
          // Thông tin Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4, left: 4),
                      child: Text('đ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}