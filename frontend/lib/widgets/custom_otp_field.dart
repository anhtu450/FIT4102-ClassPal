import 'package:flutter/material.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox( // 🔥 Dùng SizedBox cố định kích thước cho chuẩn
          width: 65,
          height: 70,
          child: TextField(
            autofocus: index == 0 ? true : false, // Ô đầu tiên tự hiện bàn phím
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                // 🔥 "Phép thuật": Tự nhảy sang ô tiếp theo
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && index > 0) {
                // 🔥 "Phép thuật": Tự lùi về khi xoá
                FocusScope.of(context).previousFocus();
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '', // Ẩn cái chữ 0/1 ở dưới
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Color(0xFF00E5FF)), // Màu Cyan ClassPal
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        );
      }),
    );
  }
}