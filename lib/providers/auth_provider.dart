import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  User? get user => _user;

  void _init() {
    _isLoading = false;
    notifyListeners();
  }

  AuthProvider() {
    _init();
  }

  Future<bool> signUp(String email, String password, String fullName) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // Simulasi signup logic
      await Future.delayed(const Duration(seconds: 1));
      // Simpan data user ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_fullName_$email', fullName);
      await prefs.setString('user_password_$email', password); // Simpan password juga untuk simulasi
      _user = User(
        id: DateTime.now().toString(), // Simulasi ID
        email: email,
        fullName: fullName,
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // Simulasi signin logic
      await Future.delayed(const Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      final storedPassword = prefs.getString('user_password_$email');
      final fullName = prefs.getString('user_fullName_$email') ?? 'Pengguna';
      if (storedPassword == null || storedPassword != password) {
        _error = 'Email atau password salah';
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _user = User(
        id: 'user-123', // Simulasi ID
        email: email,
        fullName: fullName,
      );
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _isAuthenticated = false;
      _user = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}