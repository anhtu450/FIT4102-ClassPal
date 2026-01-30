import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // Quản lý trạng thái toàn cục
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
