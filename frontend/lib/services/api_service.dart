import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  // 💡 10.0.2.2 cho máy ảo Android, localhost cho Web/iOS/Windows
  static const String baseUrl = "http://10.0.2.2:5158/api";

  // -------------------------------------------------------------------
  // 👤 MODULE: NGƯỜI DÙNG (USER)
  // -------------------------------------------------------------------

  // 1. Đăng nhập (Lấy thông tin User theo studentId)
  static Future<Map<String, dynamic>?> login(String studentId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/User/$studentId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print("❌ Lỗi Login: $e");
    }
    return null;
  }

  // 2. Đăng ký User mới (Gửi dữ liệu lên SQL Server)
  static Future<bool> registerUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/User'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("❌ Lỗi Register: $e");
      return false;
    }
  }

  // -------------------------------------------------------------------
  // 📝 MODULE: NHIỆM VỤ & TRỰC NHẬT (TASK - FR1)
  // -------------------------------------------------------------------

  // 3. Lấy toàn bộ danh sách Task
  static Future<List<dynamic>> getTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Task'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print("❌ Lỗi GetTasks: $e");
    }
    return [];
  }

  // 4. Thêm nhiệm vụ mới (Dành cho Lớp trưởng)
  static Future<bool> addTask(Map<String, dynamic> taskData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Task'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(taskData),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("❌ Lỗi AddTask: $e");
      return false;
    }
  }

  // 5. Xác nhận hoàn thành Task (PUT)
  static Future<bool> completeTask(int id) async {
    try {
      final response = await http.put(Uri.parse('$baseUrl/Task/$id/complete'));
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("❌ Lỗi CompleteTask: $e");
      return false;
    }
  }

  // 6. Xóa nhiệm vụ (DELETE)
  static Future<bool> deleteTask(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/Task/$id'));
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("❌ Lỗi DeleteTask: $e");
      return false;
    }
  }

  // -------------------------------------------------------------------
  // 🎉 MODULE: SỰ KIỆN (EVENT - FR3)
  // -------------------------------------------------------------------

  // 7. Lấy danh sách sự kiện lớp
  static Future<List<dynamic>> getEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Event'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print("❌ Lỗi GetEvents: $e");
    }
    return [];
  }

  // 8. Tạo sự kiện mới (Dành cho Lớp trưởng)
  static Future<bool> addEvent(Map<String, dynamic> eventData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Event'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(eventData),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("❌ Lỗi AddEvent: $e");
      return false;
    }
  }
}