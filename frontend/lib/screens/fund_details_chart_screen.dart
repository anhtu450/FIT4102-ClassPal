// Đường dẫn: lib/screens/fund_details_chart_screen.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/app_session.dart';

class FundDetailsChartScreen extends StatelessWidget {
  const FundDetailsChartScreen({super.key});

  final Color primaryOrange = const Color(0xFFF05123);
  final Color successGreen = const Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildAppBarTitle(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.black), 
            onPressed: () => Navigator.pushNamed(context, '/reminder')
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TỔNG SỐ DƯ (Lấy dữ liệu thực từ AppSession)
            const Text('Tổng số dư hiện tại', style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppSession.formatCurrency(AppSession.totalFund).replaceAll(' đ', ''), 
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Color(0xFF111827))
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 4),
                  child: Text('đ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade300)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTrendingBadge(),
            const SizedBox(height: 32),

            // 2. BIỂU ĐỒ PHÂN BỔ
            _buildDonutChartCard(),
            const SizedBox(height: 32),

            // 3. CÁC NÚT CHỨC NĂNG (Đã đấu nối điều hướng)
            Row(
              children: [
                _buildQuickAction(
                  context, 
                  Icons.add_to_photos_rounded, 'ĐÓNG QUỸ', Colors.orange, 
                  () => _showPaymentNotice(context)
                ),
                _buildQuickAction(
                  context, 
                  Icons.bar_chart_rounded, 'BÁO CÁO', Colors.deepOrange, 
                  () => Navigator.pushNamed(context, '/finance_report')
                ),
                _buildQuickAction(
                  context, 
                  Icons.history_rounded, 'LỊCH SỬ', Colors.orangeAccent, 
                  () => Navigator.pushNamed(context, '/expense_log')
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 4. GIAO DỊCH GẦN ĐÂY (Dữ liệu động)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giao dịch gần đây', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/expense_log'), 
                  child: Text('Xem tất cả', style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold))
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDynamicTransactionList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.account_balance_wallet, color: primaryOrange, size: 20),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CLASSPAL', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
            Text('Quỹ Lớp 12A1', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendingBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: successGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up_rounded, color: successGreen, size: 16),
          const SizedBox(width: 4),
          Text('+2.4% so với tháng trước', style: TextStyle(color: successGreen, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10)],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 12),
                Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicTransactionList() {
    final history = AppSession.expenseHistory.take(3).toList(); // Lấy 3 giao dịch mới nhất
    return Column(
      children: history.map((item) {
        return _buildTransaction(
          item['title'], 
          item['date'] ?? 'Vừa xong', 
          (item['isIncome'] ? '+' : '-') + AppSession.formatCurrency(item['amount']), 
          item['isIncome'] ? Icons.person_rounded : Icons.restaurant_rounded, 
          item['isIncome'] ? Colors.blue.shade50 : Colors.blueGrey.shade50, 
          item['isIncome'] ? Colors.blueAccent : Colors.blueGrey.shade600, 
          item['isIncome']
        );
      }).toList(),
    );
  }

  Widget _buildTransaction(String name, String date, String amount, IconData icon, Color bg, Color iconColor, bool isIncome) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF111827))),
                Text(date, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isIncome ? successGreen : Colors.black87)),
        ],
      ),
    );
  }

  void _showPaymentNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tính năng thanh toán QR đang được tích hợp!')),
    );
  }

  // --- PHẦN BIỂU ĐỒ GIỮ NGUYÊN LOGIC VẼ CỦA TÚ ---
  Widget _buildDonutChartCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade100, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phân bổ chi phí', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
              Text('THÁNG ${DateTime.now().month}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade400, letterSpacing: 1)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 130, height: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(size: const Size(130, 130), painter: DonutPainter()),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tổng chi', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
                        Text('4.8M', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF111827))),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem(const Color(0xFF00E5FF), 'Sách vở', '35%'),
                    const SizedBox(height: 12),
                    _buildLegendItem(const Color(0xFF7B61FF), 'Sự kiện', '30%'),
                    const SizedBox(height: 12),
                    _buildLegendItem(const Color(0xFFC0A9FF), 'Cơ sở', '20%'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, String percent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600, fontWeight: FontWeight.w500)),
          ],
        ),
        Text(percent, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF111827))),
      ],
    );
  }
}

// GIỮ NGUYÊN CUSTOM PAINTER CỦA TÚ
class DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 16.0;
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;

    paint.color = Colors.grey.shade100;
    canvas.drawCircle(center, radius - strokeWidth / 2, paint);

    double startAngle = -math.pi / 2;
    _drawArc(canvas, center, radius, strokeWidth, startAngle, 2 * math.pi * 0.35, const Color(0xFF00E5FF));
    startAngle += 2 * math.pi * 0.35;
    _drawArc(canvas, center, radius, strokeWidth, startAngle, 2 * math.pi * 0.30, const Color(0xFF7B61FF));
    startAngle += 2 * math.pi * 0.30;
    _drawArc(canvas, center, radius, strokeWidth, startAngle, 2 * math.pi * 0.20, const Color(0xFFC0A9FF));
  }

  void _drawArc(Canvas canvas, Offset center, double radius, double strokeWidth, double startAngle, double sweepAngle, Color color) {
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, sweepAngle - 0.1, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}