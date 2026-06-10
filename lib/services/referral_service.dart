import 'api_client.dart';

class ReferralService {
  /// GET /api/referral/code
  Future<String?> getCode() async {
    final res = await apiClient.get('/api/referral/code');
    final data = res['data'] as Map<String, dynamic>;
    return data['code'] as String?;
  }

  /// GET /api/referral/stats
  Future<Map<String, dynamic>> getStats() async {
    final res = await apiClient.get('/api/referral/stats');
    return res['data'] as Map<String, dynamic>;
  }

  /// POST /api/referral/validate
  Future<Map<String, dynamic>> validateCode(String code) async {
    final res = await apiClient.post('/api/referral/validate', body: {
      'code': code,
    });
    return res['data'] as Map<String, dynamic>;
  }
}

final referralService = ReferralService();
