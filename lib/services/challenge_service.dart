import 'api_client.dart';

class ChallengeService {
  /// GET /api/challenges/overview
  Future<Map<String, dynamic>> getOverview() async {
    final res = await apiClient.get('/api/challenges/overview');
    return res['data'] as Map<String, dynamic>;
  }

  /// POST /api/challenges/:id/join
  Future<Map<String, dynamic>> joinChallenge(String id) async {
    final res = await apiClient.post('/api/challenges/$id/join');
    return res['data'] as Map<String, dynamic>;
  }
}

final challengeService = ChallengeService();
