import 'api_client.dart';

class RewardService {
  /// GET /api/rewards/balance
  Future<Map<String, dynamic>> getBalance() async {
    final res = await apiClient.get('/api/rewards/balance');
    return res['data'] as Map<String, dynamic>;
  }

  /// GET /api/rewards/history
  Future<List<dynamic>> getHistory({String? type}) async {
    final params = <String, String>{};
    if (type != null) params['type'] = type;
    final res = await apiClient.get('/api/rewards/history', queryParams: params.isNotEmpty ? params : null);
    return res['data'] as List<dynamic>;
  }

  /// GET /api/rewards/ewallet
  Future<Map<String, dynamic>?> getEwallet() async {
    final res = await apiClient.get('/api/rewards/ewallet');
    return res['data'] as Map<String, dynamic>?;
  }

  /// PUT /api/rewards/ewallet
  Future<Map<String, dynamic>> setEwallet({
    required String platform,
    required String phone,
  }) async {
    final res = await apiClient.put('/api/rewards/ewallet', body: {
      'platform': platform,
      'phone': phone,
    });
    return res['data'] as Map<String, dynamic>;
  }

  /// POST /api/rewards/redeem
  Future<Map<String, dynamic>> redeem({
    required String platform,
    required int amountRp,
  }) async {
    final res = await apiClient.post('/api/rewards/redeem', body: {
      'platform': platform,
      'amountRp': amountRp,
    });
    return res['data'] as Map<String, dynamic>;
  }
}

final rewardService = RewardService();
