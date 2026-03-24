// Đường dẫn: lib/screens/leaderboard_screen.dart

import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  final Color primaryOrange = const Color(0xFFF05123);

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mô phỏng
    final List<Map<String, dynamic>> top3 = [
      {'rank': 2, 'name': 'Nhóm Bạc', 'score': '92%', 'color': const Color(0xFFC0C0C0)},
      {'rank': 1, 'name': 'Nhóm Vàng', 'score': '98%', 'color': const Color(0xFFFFD700)},
      {'rank': 3, 'name': 'Nhóm Đồng', 'score': '87%', 'color': const Color(0xFFCD7F32)},
    ];

    final List<Map<String, dynamic>> otherGroups = [
      {'name': 'Nhóm 4', 'score': 0.80, 'percent': '80%'},
      {'name': 'Nhóm 5', 'score': 0.75, 'percent': '75%'},
      {'name': 'Nhóm 6', 'score': 0.68, 'percent': '68%'},
      {'name': 'Nhóm 7', 'score': 0.62, 'percent': '62%'},
      {'name': 'Nhóm 8', 'score': 0.54, 'percent': '54%'},
      {'name': 'Nhóm 9', 'score': 0.45, 'percent': '45%'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Bảng Xếp Hạng ClassPal',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Dùng làm Tab nên không cần nút Back
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏆 1. PHẦN BỤC VINH QUANG (PODIUM)
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPodiumBlock(top3[0], 120), // Hạng 2
                  const SizedBox(width: 10),
                  _buildPodiumBlock(top3[1], 160), // Hạng 1
                  const SizedBox(width: 10),
                  _buildPodiumBlock(top3[2], 90),  // Hạng 3
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 📜 2. DANH SÁCH NHÓM
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Danh sách nhóm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: otherGroups.length,
              itemBuilder: (context, index) {
                final group = otherGroups[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${group['name']} - ${group['percent']}',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // THANH TIẾN ĐỘ (Progress Bar)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: group['score'],
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade100,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryOrange),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // 🧭 ĐÃ XÓA SẠCH BOTTOM NAVIGATION BAR ĐỂ ĐỒNG BỘ "GOM TAB"
    );
  }

  // WIDGET: Vẽ bục vinh quang
  Widget _buildPodiumBlock(Map<String, dynamic> data, double height) {
    bool isFirst = data['rank'] == 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Icon Huy hiệu/Vòng nguyệt quế
        Icon(
          isFirst ? Icons.stars_rounded : Icons.workspace_premium_rounded,
          color: data['color'],
          size: isFirst ? 50 : 40,
        ),
        const SizedBox(height: 4),
        Text(data['name'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(data['score'], style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 8),
        // Khối bục 3D giả lập bằng Gradient
        Container(
          width: 85,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryOrange, primaryOrange.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            boxShadow: [
              BoxShadow(color: primaryOrange.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Center(
            child: Text(
              data['rank'].toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}