import 'package:flutter/material.dart';

class LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final int score;

  const LeaderboardItem({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
  });

  // 🔥 Hàm lấy màu sắc theo thứ hạng
  Color _getRankColor() {
    if (rank == 1) return const Color(0xFFFFD700); // Vàng Gold
    if (rank == 2) return const Color(0xFFC0C0C0); // Bạc Silver
    if (rank == 3) return const Color(0xFFCD7F32); // Đồng Bronze
    return const Color(0xFF00E5FF); // Cyan mặc định của app
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = _getRankColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 🏆 SỐ THỨ HẠNG
          Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$rank',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: rankColor,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // 👤 TÊN VÀ THANH ĐIỂM
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // 🔥 Thanh tiến trình đã được bo tròn đầu
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: score / 100,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(rankColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // 🎯 ĐIỂM SỐ
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: rankColor,
                ),
              ),
              const Text(
                'pts',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}