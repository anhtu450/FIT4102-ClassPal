import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // 🔥 Thêm cái này để Tú gắn thêm nút Search/Filter bên phải
  final bool showBackButton;   // 🔥 Tự động ẩn/hiện nút quay lại

  const CustomAppBar({
    Key? key, 
    required this.title, 
    this.actions,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black, // Chữ đen cho sang
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white, // Nền trắng hiện đại
      elevation: 1, // Bóng đổ nhẹ tạo chiều sâu
      iconTheme: const IconThemeData(color: Colors.black), // Icon mặc định màu đen
      
      // 🔥 Tự thiết kế nút Back cho đồng bộ "mũi tên iOS"
      leading: showBackButton ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        onPressed: () => Navigator.maybePop(context),
      ) : null,
      
      actions: actions, // Truyền các nút chức năng vào đây
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}