import 'package:flutter/material.dart';

class TopRankCard extends StatelessWidget {
  final int rank;
  final String name;
  final int score;

  const TopRankCard({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 Cấu hình màu sắc và kích thước theo thứ hạng
    Color medalColor;
    IconData medalIcon;
    double avatarRadius;
    double elevation;

    switch (rank) {
      case 1:
        medalColor = const Color(0xFFFFD700); // Vàng Gold
        medalIcon = Icons.emoji_events;       // Cúp vàng
        avatarRadius = 45.0;                  // To nhất
        elevation = 10.0;
        break;
      case 2:
        medalColor = const Color(0xFFC0C0C0); // Bạc Silver
        medalIcon = Icons.workspace_premium;  // Huy chương bạc
        avatarRadius = 35.0;
        elevation = 5.0;
        break;
      case 3:
        medalColor = const Color(0xFFCD7F32); // Đồng Bronze
        medalIcon = Icons.military_tech;      // Huy chương đồng
        avatarRadius = 35.0;
        elevation = 5.0;
        break;
      default:
        medalColor = Colors.grey;
        medalIcon = Icons.person;
        avatarRadius = 30.0;
        elevation = 0;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🏆 KHU VỰC AVATAR & HUY CHƯƠNG
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: medalColor, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: medalColor.withOpacity(0.3),
                    blurRadius: elevation,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.grey.shade200,
                // Tú có thể thay bằng NetworkImage nếu có link ảnh thật
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: avatarRadius * 0.8,
                    fontWeight: FontWeight.bold,
                    color: medalColor,
                  ),
                ),
              ),
            ),
            // Biểu tượng huy chương nhỏ đè lên góc dưới
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Icon(medalIcon, color: medalColor, size: 20),
            ),
          ],
        ),
        
        const SizedBox(height: 12),

        // 📝 TÊN & ĐIỂM SỐ
        Text(
          name,
          style: TextStyle(
            fontSize: rank == 1 ? 18 : 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: medalColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$score pts',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: medalColor,
            ),
          ),
        ),
      ],
    );
  }
}