import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

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
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final fbUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (fbUser != null) {
      _user = User(id: fbUser.uid, email: fbUser.email ?? '', fullName: fbUser.displayName ?? '');
      _isAuthenticated = true;
    } else {
      _user = null;
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<bool> signUp(String email, String password, String fullName) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final credential = await fb_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(fullName);
      await credential.user?.reload();
      final updatedUser = fb_auth.FirebaseAuth.instance.currentUser;
      _user = User(id: updatedUser?.uid ?? '', email: updatedUser?.email ?? '', fullName: updatedUser?.displayName ?? '');
      _isAuthenticated = false; // Tetap false agar user harus login dulu
      _isLoading = false;
      notifyListeners();
      return true;
    } on fb_auth.FirebaseAuthException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
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
      final credential = await fb_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fbUser = credential.user;
      _user = User(id: fbUser?.uid ?? '', email: fbUser?.email ?? '', fullName: fbUser?.displayName ?? '');
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } on fb_auth.FirebaseAuthException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
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
      await fb_auth.FirebaseAuth.instance.signOut();
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