// Đường dẫn: lib/screens/asset_management_screen.dart

import 'package:flutter/material.dart';
import '../utils/app_session.dart';

class AssetManagementScreen extends StatefulWidget {
  const AssetManagementScreen({super.key});

  @override
  State<AssetManagementScreen> createState() => _AssetManagementScreenState();
}

class _AssetManagementScreenState extends State<AssetManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedCategory = 'Tất cả';

  // Màu chủ đạo mới của App
  final Color primaryOrange = const Color(0xFFF05123);

  final List<String> _categories = ['Tất cả', 'Thiết bị số', 'Văn phòng', 'Khác'];

  // Cập nhật lại trạng thái in hoa theo Design mới
  final List<Map<String, String>> _allAssets = [
    {'name': 'Máy chiếu Epson', 'code': 'ASSET-2024-001', 'location': 'Phòng họp A1', 'status': 'SẴN SÀNG', 'statusColor': 'green', 'icon': 'projector', 'category': 'Thiết bị số'},
    {'name': 'Điều khiển Tivi', 'code': 'ASSET-2024-045', 'borrower': 'Nguyễn Văn A', 'status': 'ĐANG MƯỢN', 'statusColor': 'orange', 'icon': 'remote', 'category': 'Thiết bị số'},
    {'name': 'MacBook Pro M1', 'code': 'ASSET-2024-112', 'location': 'Kho kỹ thuật', 'status': 'SẴN SÀNG', 'statusColor': 'green', 'icon': 'laptop', 'category': 'Thiết bị số'},
    {'name': 'Tai nghe Sony', 'code': 'ASSET-2024-089', 'returnTime': '18:00 Hôm nay', 'status': 'ĐANG MƯỢN', 'statusColor': 'orange', 'icon': 'headphones', 'category': 'Khác'},
    {'name': 'Xe đạp điện VinFast', 'code': 'ASSET-2024-204', 'expectedCompletion': '25/10', 'status': 'BẢO TRÌ', 'statusColor': 'grey', 'icon': 'bike', 'category': 'Khác'},
  ];

  List<Map<String, String>> get _filteredAssets {
    return _allAssets.where((asset) {
      final matchesSearch = asset['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                            asset['code']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Tất cả' || asset['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'projector': return Icons.videocam;
      case 'remote': return Icons.settings_remote;
      case 'laptop': return Icons.laptop_mac;
      case 'headphones': return Icons.headphones;
      case 'bike': return Icons.pedal_bike;
      default: return Icons.inventory_2;
    }
  }

  Color _getStatusColor(String colorName) {
    switch (colorName) {
      case 'green': return const Color(0xFF10B981); // Xanh lá mượt
      case 'orange': return const Color(0xFFF59E0B); // Cam
      case 'grey': return const Color(0xFF6B7280); // Xám đậm
      default: return Colors.grey;
    }
  }

  // 🔥 FORM THÊM TÀI SẢN MỚI
  void _showAddAssetModal() {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController codeCtrl = TextEditingController();
    final TextEditingController locCtrl = TextEditingController();
    String selectedCat = 'Thiết bị số';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20, right: 20, top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thêm tài sản mới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Tên tài sản (VD: Bút chỉ bảng)', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  TextField(controller: codeCtrl, decoration: const InputDecoration(labelText: 'Mã tài sản (VD: ASSET-002)', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  TextField(controller: locCtrl, decoration: const InputDecoration(labelText: 'Vị trí lưu trữ (VD: Tủ BCS)', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedCat,
                    decoration: const InputDecoration(labelText: 'Danh mục', border: OutlineInputBorder()),
                    items: ['Thiết bị số', 'Văn phòng', 'Khác'].map((String category) {
                      return DropdownMenuItem(value: category, child: Text(category));
                    }).toList(),
                    onChanged: (newValue) => setModalState(() => selectedCat = newValue!),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14)
                      ),
                      onPressed: () {
                        if (nameCtrl.text.isNotEmpty) {
                          setState(() {
                            _allAssets.insert(0, {
                              'name': nameCtrl.text,
                              'code': codeCtrl.text.isEmpty ? 'ASSET-NEW' : codeCtrl.text,
                              'location': locCtrl.text.isEmpty ? 'Chưa phân bổ' : locCtrl.text,
                              'status': 'SẴN SÀNG',
                              'statusColor': 'green',
                              'icon': selectedCat == 'Thiết bị số' ? 'laptop' : (selectedCat == 'Văn phòng' ? 'inventory_2' : 'bike'),
                              'category': selectedCat,
                            });
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thêm tài sản thành công!')));
                        }
                      },
                      child: const Text('LƯU TÀI SẢN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 FIX CHUẨN XÁC: Mặc định là Sinh viên để khóa an toàn nút (+)
    final user = AppSession.currentUser ?? AppSession.mockStudent;
    final bool isAdmin = user.role == 'admin';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏷️ HEADER
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 16, top: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quản lý tài sản',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87),
                      onPressed: () => Navigator.pushNamed(context, '/asset_history'),
                    ),
                  )
                ],
              ),
            ),

            // 🔍 THANH TÌM KIẾM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm thiết bị, mã tài sản...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            
            // 📑 CÁC NÚT LỌC
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final bool isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryOrange : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 📦 DANH SÁCH TÀI SẢN
            Expanded(
              child: _filteredAssets.isEmpty 
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: _filteredAssets.length,
                itemBuilder: (context, index) {
                  final asset = _filteredAssets[index];
                  final color = _getStatusColor(asset['statusColor']!);
                  final icon = _getIcon(asset['icon']!);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade100),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                      ]
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (asset['status'] == 'SẴN SÀNG') {
                          Navigator.pushNamed(context, '/borrow_device');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thiết bị này hiện đang ${asset['status']!.toLowerCase()}')));
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 70, width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(icon, color: Colors.grey.shade600, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        asset['name']!, 
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                                      child: Text(asset['status']!, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text('Mã: ${asset['code']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                                const SizedBox(height: 2),
                                if (asset['location'] != null) Text('Vị trí: ${asset['location']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                                if (asset['borrower'] != null) Text('Người mượn: ${asset['borrower']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                                if (asset['returnTime'] != null) Text('Hạn trả: ${asset['returnTime']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                                if (asset['expectedCompletion'] != null) Text('Dự kiến xong: ${asset['expectedCompletion']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      // 🔥 NÚT (+) CAM CHỈ HIỆN ĐÚNG CHO ADMIN
      floatingActionButton: isAdmin ? FloatingActionButton(
        backgroundColor: primaryOrange,
        elevation: 4,
        onPressed: _showAddAssetModal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ) : null,
      
      // 🔥 ĐÃ DỌN DẸP SẠCH SẼ BOTTOM NAVIGATION BAR CŨ (Để dùng chung ở main_screen)
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade200),
          const SizedBox(height: 16),
          const Text('Không tìm thấy tài sản', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}