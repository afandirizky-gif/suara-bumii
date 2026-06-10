import 'api_client.dart';

class DropPointService {
  /// GET /api/drop-points
  Future<List<dynamic>> getDropPoints({
    String? material,
    String? query,
    double? lat,
    double? lng,
  }) async {
    final params = <String, String>{};
    if (material != null) params['material'] = material;
    if (query != null) params['q'] = query;
    if (lat != null) params['lat'] = lat.toString();
    if (lng != null) params['lng'] = lng.toString();
    final res = await apiClient.get('/api/drop-points',
        queryParams: params.isNotEmpty ? params : null);
    return res['data'] as List<dynamic>;
  }

  /// GET /api/drop-points/:id
  Future<Map<String, dynamic>> getDropPointDetail(String id,
      {double? lat, double? lng}) async {
    final params = <String, String>{};
    if (lat != null) params['lat'] = lat.toString();
    if (lng != null) params['lng'] = lng.toString();
    final res = await apiClient.get('/api/drop-points/$id',
        queryParams: params.isNotEmpty ? params : null);
    return res['data'] as Map<String, dynamic>;
  }

  /// GET /api/drop-points/:id/status
  Future<Map<String, dynamic>> getStatus(String id) async {
    final res = await apiClient.get('/api/drop-points/$id/status');
    return res['data'] as Map<String, dynamic>;
  }
}

final dropPointService = DropPointService();
