import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_client.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;
  String? _accessToken;
  String? _refreshToken;
  bool _isLoading = false;

  Map<String, dynamic>? get user => _user;
  String? get accessToken => _accessToken;
  bool get isLoggedIn => _accessToken != null && _user != null;
  bool get isLoading => _isLoading;

  String get userName => _user?['fullName'] ?? 'User';
  String get userEmail => _user?['email'] ?? '';
  String? get userPhoto => _user?['profilePhotoUrl'];

  /// Try to auto-login from stored token
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final refresh = prefs.getString('refreshToken');

    if (token == null || refresh == null) return false;

    _accessToken = token;
    _refreshToken = refresh;
    apiClient.setToken(token);

    try {
      // Try refreshing the token to get fresh user data
      final result = await authService.refreshToken(refreshToken: refresh);
      await _handleAuthResponse(result);
      return true;
    } catch (e) {
      // Token expired or invalid, clear everything
      await _clearAuth();
      return false;
    }
  }

  /// Login with email & password
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await authService.login(
        email: email,
        password: password,
      );
      await _handleAuthResponse(result);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Register a new account
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String address,
    String? referralCode,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await authService.register(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
        address: address,
        referralCode: referralCode,
      );
      await _handleAuthResponse(result);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await authService.logout(refreshToken: _refreshToken);
    } catch (_) {
      // Ignore errors during logout
    }
    await _clearAuth();
    notifyListeners();
  }

  /// Update user data locally (after profile edit)
  void updateUser(Map<String, dynamic> updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  Future<void> _handleAuthResponse(Map<String, dynamic> result) async {
    _accessToken = result['accessToken'] as String?;
    _refreshToken = result['refreshToken'] as String?;
    _user = result['user'] as Map<String, dynamic>?;

    apiClient.setToken(_accessToken);

    // Persist tokens
    final prefs = await SharedPreferences.getInstance();
    if (_accessToken != null) {
      await prefs.setString('accessToken', _accessToken!);
    }
    if (_refreshToken != null) {
      await prefs.setString('refreshToken', _refreshToken!);
    }
  }

  Future<void> _clearAuth() async {
    _user = null;
    _accessToken = null;
    _refreshToken = null;
    apiClient.setToken(null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
