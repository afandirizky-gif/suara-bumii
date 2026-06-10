import 'api_client.dart';

class AuthService {
  /// POST /api/auth/register
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String address,
    String? referralCode,
  }) async {
    final body = <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
    };
    if (referralCode != null && referralCode.isNotEmpty) {
      body['referralCode'] = referralCode;
    }
    return await apiClient.post('/api/auth/register', body: body);
  }

  /// POST /api/auth/login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await apiClient.post('/api/auth/login', body: {
      'email': email,
      'password': password,
    });
  }

  /// POST /api/auth/otp/send
  Future<Map<String, dynamic>> sendOtp({
    required String phone,
    String? email,
    String purpose = 'register',
  }) async {
    final body = <String, dynamic>{
      'phone': phone,
      'purpose': purpose,
    };
    if (email != null) body['email'] = email;
    return await apiClient.post('/api/auth/otp/send', body: body);
  }

  /// POST /api/auth/otp/resend
  Future<Map<String, dynamic>> resendOtp({
    required String phone,
    String? email,
    String purpose = 'register',
  }) async {
    final body = <String, dynamic>{
      'phone': phone,
      'purpose': purpose,
    };
    if (email != null) body['email'] = email;
    return await apiClient.post('/api/auth/otp/resend', body: body);
  }

  /// POST /api/auth/otp/verify
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String code,
    String purpose = 'register',
  }) async {
    return await apiClient.post('/api/auth/otp/verify', body: {
      'phone': phone,
      'code': code,
      'purpose': purpose,
    });
  }

  /// POST /api/auth/refresh
  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    return await apiClient.post('/api/auth/refresh', body: {
      'refreshToken': refreshToken,
    });
  }

  /// POST /api/auth/logout
  Future<Map<String, dynamic>> logout({String? refreshToken}) async {
    final body = <String, dynamic>{};
    if (refreshToken != null) body['refreshToken'] = refreshToken;
    return await apiClient.post('/api/auth/logout', body: body);
  }
}

final authService = AuthService();
