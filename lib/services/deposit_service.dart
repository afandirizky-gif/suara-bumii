import 'api_client.dart';

class DepositService {
  /// POST /api/deposits
  Future<Map<String, dynamic>> createDeposit({
    required String dropPointId,
    required List<Map<String, dynamic>> categories,
  }) async {
    final res = await apiClient.post('/api/deposits', body: {
      'dropPointId': dropPointId,
      'categories': categories,
    });
    return res['data'] as Map<String, dynamic>;
  }

  /// GET /api/deposits/history
  Future<List<dynamic>> getHistory() async {
    final res = await apiClient.get('/api/deposits/history');
    return res['data'] as List<dynamic>;
  }

  /// GET /api/deposits/verify/:token
  Future<Map<String, dynamic>> verifyToken(String token) async {
    final res = await apiClient.get('/api/deposits/verify/$token');
    return res['data'] as Map<String, dynamic>;
  }
}

final depositService = DepositService();
