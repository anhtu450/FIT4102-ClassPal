import 'package:flutter/material.dart';

class FundSummaryCard extends StatelessWidget {
  final String currentBalance;
  final String percentageChange;

  const FundSummaryCard({
    super.key,
    required this.currentBalance,
    required this.percentageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // 💰 PHẦN 1: SỐ DƯ HIỆN TẠI (Làm nổi bật nhất)
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E5FF), Color(0xFF00B8D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tình hình quỹ hiện tại',
                  style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentBalance,
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        percentageChange,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 📊 PHẦN 2: THU - CHI - RÒNG (Chia cột cho gọn)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMiniStat('Tổng thu', '62.8M', Colors.blue),
                _buildDivider(),
                _buildMiniStat('Tổng chi', '17.8M', Colors.redAccent),
                _buildDivider(),
                _buildMiniStat('Số dư ròng', '45.0M', Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget phụ: Thanh chia dọc nhỏ
  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: Colors.grey.shade200);
  }

  // Widget phụ: Từng cột chỉ số nhỏ
  Widget _buildMiniStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}