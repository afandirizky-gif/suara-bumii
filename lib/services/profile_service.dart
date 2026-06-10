import 'api_client.dart';

class ProfileService {
  /// GET /api/profile
  Future<Map<String, dynamic>> getProfile() async {
    final res = await apiClient.get('/api/profile');
    return res['data'] as Map<String, dynamic>;
  }

  /// PATCH /api/profile
  Future<Map<String, dynamic>> updateProfile({
    String? fullName,
    String? phone,
    String? address,
  }) async {
    final body = <String, dynamic>{};
    if (fullName != null) body['fullName'] = fullName;
    if (phone != null) body['phone'] = phone;
    if (address != null) body['address'] = address;
    final res = await apiClient.patch('/api/profile', body: body);
    return res['data'] as Map<String, dynamic>;
  }

  /// GET /api/profile/stats
  Future<Map<String, dynamic>> getStats() async {
    final res = await apiClient.get('/api/profile/stats');
    return res['data'] as Map<String, dynamic>;
  }

  /// GET /api/profile/badges
  Future<List<dynamic>> getBadges() async {
    final res = await apiClient.get('/api/profile/badges');
    return res['data'] as List<dynamic>;
  }

  /// GET /api/profile/activities
  Future<List<dynamic>> getActivities({int limit = 10}) async {
    final res = await apiClient.get('/api/profile/activities',
        queryParams: {'limit': limit.toString()});
    return res['data'] as List<dynamic>;
  }
}

final profileService = ProfileService();
