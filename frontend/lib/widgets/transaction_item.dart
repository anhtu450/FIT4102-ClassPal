import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final String? date;
  final String? subtitle;
  final bool isIncome; // 🔥 Dùng cái này để làm "linh hồn" cho thẻ

  const TransactionItem({
    super.key,
    required this.title,
    required this.amount,
    this.date,
    this.subtitle,
    this.isIncome = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 Tự động xác định màu sắc và icon theo loại giao dịch
    final Color themeColor = isIncome ? Colors.green : Colors.redAccent;
    final IconData directionIcon = isIncome ? Icons.arrow_downward : Icons.arrow_upward;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        
        // 📥 ICON CHỈ HƯỚNG
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(directionIcon, color: themeColor, size: 20),
        ),

        // 📝 THÔNG TIN GIAO DỊCH
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitle != null) 
              Text(subtitle!, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            if (date != null)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(date!, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
              ),
          ],
        ),

        // 💰 SỐ TIỀN (Tự thêm dấu +/-)
        trailing: Text(
          '${isIncome ? "+" : "-"}$amount',
          style: TextStyle(
            color: themeColor,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}