// Đường dẫn: lib/models/user_model.dart

class UserModel {
  final int id;           
  final String studentId; 
  final String name;      // 🔥 Đã đổi từ fullName thành name theo ý sếp
  final String role;      
  final String? email;    
  final String? phone;
  final String school;

  UserModel({
    required this.id,
    required this.studentId,
    required this.name,   // 🔥 Đồng bộ name
    required this.role,
    this.email,
    this.phone = '0987.xxx.xxx',
    this.school = 'Đại học Đại Nam',
  });

  /// 🔥 HÀM "MA THUẬT": copyWith
  UserModel copyWith({
    int? id,
    String? studentId,
    String? name,        // 🔥 Đồng bộ name
    String? role,
    String? email,
    String? phone,
    String? school,
  }) {
    return UserModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      school: school ?? this.school,
    );
  }

  // Chuyển đổi sang Map để gửi lên Server (Vẫn gửi key 'fullName' để Backend .NET hiểu)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'fullName': name,  // 🔥 Map biến name vào key 'fullName' của Backend
      'role': role,
      'email': email,
      'phone': phone,
      'school': school,
    };
  }

  // 🔥 QUAN TRỌNG: Tạo User từ dữ liệu Json (Map) của Backend .NET 9
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      studentId: json['studentId'] ?? '',
      name: json['fullName'] ?? '', // 🔥 Hứng 'fullName' từ server đưa vào biến 'name'
      role: json['role'] ?? 'Student',
      email: json['email'],
      phone: json['phone'] ?? '0987.xxx.xxx',
      school: json['school'] ?? 'Đại học Đại Nam',
    );
  }
}