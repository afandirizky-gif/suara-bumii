import 'api_client.dart';

class DashboardService {
  /// GET /api/dashboard
  Future<Map<String, dynamic>> getDashboard() async {
    final res = await apiClient.get('/api/dashboard');
    return res['data'] as Map<String, dynamic>;
  }
}

final dashboardService = DashboardService();
