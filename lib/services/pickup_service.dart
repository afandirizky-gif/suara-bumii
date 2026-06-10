import 'api_client.dart';

class PickupService {
  /// GET /api/pickups
  Future<List<dynamic>> getPickups({String? status}) async {
    final params = <String, String>{};
    if (status != null) params['status'] = status;
    final res = await apiClient.get('/api/pickups',
        queryParams: params.isNotEmpty ? params : null);
    return res['data'] as List<dynamic>;
  }

  /// POST /api/pickups
  Future<Map<String, dynamic>> createPickup({
    required String address,
    required String scheduledAt,
    required double estimatedWeightKg,
  }) async {
    final res = await apiClient.post('/api/pickups', body: {
      'address': address,
      'scheduledAt': scheduledAt,
      'estimatedWeightKg': estimatedWeightKg,
    });
    return res['data'] as Map<String, dynamic>;
  }

  /// PATCH /api/pickups/:id
  Future<Map<String, dynamic>> updatePickup(String id, {
    String? address,
    String? scheduledAt,
    double? estimatedWeightKg,
  }) async {
    final body = <String, dynamic>{};
    if (address != null) body['address'] = address;
    if (scheduledAt != null) body['scheduledAt'] = scheduledAt;
    if (estimatedWeightKg != null) body['estimatedWeightKg'] = estimatedWeightKg;
    final res = await apiClient.patch('/api/pickups/$id', body: body);
    return res['data'] as Map<String, dynamic>;
  }

  /// DELETE /api/pickups/:id
  Future<void> cancelPickup(String id) async {
    await apiClient.delete('/api/pickups/$id');
  }
}

final pickupService = PickupService();
