import 'package:flutter/material.dart';

class FundChartMockup extends StatelessWidget {
  const FundChartMockup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220, // Tăng nhẹ kích thước để nhìn cho rõ
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 📘 Vòng ngoài cùng: Hoạt động (35%) - Màu Cyan chủ đạo
            _buildRing(
              value: 0.75, // Giả sử chi 75% cho hoạt động
              size: 200,
              color: const Color(0xFF00E5FF),
              backgroundColor: const Color(0xFF00E5FF).withOpacity(0.1),
            ),

            // 💜 Vòng giữa: Cơ sở vật chất (30%) - Màu Tím nhạt
            _buildRing(
              value: 0.55, 
              size: 155,
              color: Colors.purpleAccent,
              backgroundColor: Colors.purpleAccent.withOpacity(0.1),
            ),

            // 🟠 Vòng trong cùng: Học tập (20%) - Màu Cam
            _buildRing(
              value: 0.35,
              size: 110,
              color: Colors.orangeAccent,
              backgroundColor: Colors.orangeAccent.withOpacity(0.1),
            ),

            // 📝 Chữ hiển thị ở giữa
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tổng chi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '4.8M',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900, // Đậm nhất cho nổi bật
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'VNĐ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Hàm phụ để vẽ từng vòng tròn cho đỡ lặp code
  Widget _buildRing({
    required double value,
    required double size,
    required Color color,
    required Color backgroundColor,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: 14, // Độ dày vòng tròn vừa phải cho sang
        strokeCap: StrokeCap.round, // 🔥 Bo tròn 2 đầu vòng tròn (Rất quan trọng)
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: backgroundColor,
      ),
    );
  }
}