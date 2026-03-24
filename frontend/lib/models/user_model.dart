// Đường dẫn: lib/models/user_model.dart

class UserModel {
  final String id;
  final String name;
  final String email;
  // 🔥 Bỏ 'final' ở role để có thể thay đổi vai trò khi đăng nhập (fix lỗi gạch đỏ)
  String role; 
  final String phone;
  final String school;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone = '0987.xxx.xxx',
    this.school = 'Đại học Đại Nam',
  });

  /// 🔥 HÀM "MA THUẬT": copyWith
  /// Giúp tạo ra một bản sao mới của User và chỉ cập nhật những gì Tú muốn.
  /// Rất hữu ích khi Tú muốn đổi role mà không muốn gõ lại id, name, email...
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? school,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      school: school ?? this.school,
    );
  }

  // Tiện ích: Chuyển đổi sang Map để sau này lưu vào Local Storage hoặc gửi lên Server
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'school': school,
    };
  }

  // Tiện ích: Tạo User từ dữ liệu Json (Map)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phone: json['phone'] ?? '0987.xxx.xxx',
      school: json['school'] ?? 'Đại học Đại Nam',
    );
  }
}