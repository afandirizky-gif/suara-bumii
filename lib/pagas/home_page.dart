import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/dashboard_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _dashboard;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    try {
      final data = await dashboardService.getDashboard();
      if (mounted) {
        setState(() {
          _dashboard = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = authProvider.userName;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? _buildErrorWidget()
                : _buildContent(userName),
      ),
      bottomNavigationBar: _buildBottomNav(context, 2),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text("Gagal memuat dashboard"),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
                _error = null;
              });
              _loadDashboard();
            },
            child: const Text("Coba Lagi"),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(String userName) {
    final points = _dashboard?['points'] ?? {};
    final co2 = _dashboard?['co2'] ?? {};
    final deposits = _dashboard?['deposits'] ?? {};
    final chart = _dashboard?['depositChartLast7Days'] as List<dynamic>? ?? [];
    final activeChallenges =
        _dashboard?['activeChallenges'] as List<dynamic>? ?? [];

    final totalPoints = points['total'] ?? 0;
    final co2Total = co2['totalSavedKg'] ?? 0;
    final co2Weekly = co2['weeklyDeltaKg'] ?? 0;
    final depositCount = deposits['totalCount'] ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Profil & Nama
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selamat datang,",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B3022),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Streak Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  "Total setor: ${depositCount}x",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tombol Scan Sampah dengan AI
          _buildScanBanner(context),
          const SizedBox(height: 20),

          // Card Total Poin
          _buildPointCard(totalPoints, co2Weekly),
          const SizedBox(height: 15),

          // Row CO2 & Jumlah Setor
          Row(
            children: [
              _buildStatCard(
                  "CO2 Diselamatkan", "$co2Total kg"),
              const SizedBox(width: 15),
              _buildStatCard("Jumlah Setor", "${depositCount}x total"),
            ],
          ),
          const SizedBox(height: 25),

          // Aktivitas Setor (Grafik)
          const Text(
            "Aktivitas Setor",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B3022),
            ),
          ),
          const SizedBox(height: 12),
          _buildActivityGraph(chart),
          const SizedBox(height: 20),

          // Tombol-Tombol Aksi Utama
          _buildMainActionButtons(context),
          const SizedBox(height: 25),

          // Challenge Aktif
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Challenge Aktif",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3022),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/challenge_aktif');
                },
                child: const Text(
                  "Lihat Semua >",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ),
            ],
          ),
          if (activeChallenges.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "Belum ada challenge aktif",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ...activeChallenges.map((c) => _buildChallengeItem(
                c['title'] ?? 'Challenge',
                c['progress'] ?? 0,
                c['target'] ?? 1,
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildScanBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/scan_sampah');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B3022),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_center_focus, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Scan Sampah dengan AI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointCard(int totalPoints, dynamic weeklyDelta) {
    final sign = (weeklyDelta is num && weeklyDelta >= 0) ? '+' : '';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Point kamu", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$totalPoints",
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.circle,
                color: Colors.orange.shade300,
                size: 30,
              ),
            ],
          ),
          Text(
            "$sign$weeklyDelta kg CO2 minggu ini >",
            style: const TextStyle(color: Colors.green, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityGraph(List<dynamic> chart) {
    if (chart.isEmpty) {
      return Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text("Belum ada data aktivitas",
              style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    final maxCount = chart
        .map((c) => (c['depositCount'] as num?) ?? 0)
        .reduce((a, b) => a > b ? a : b);
    final maxVal = maxCount == 0 ? 1 : maxCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: chart.map((c) {
          final count = (c['depositCount'] as num?) ?? 0;
          final label = c['label'] ?? '';
          final height = (count / maxVal) * 60;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$count", style: const TextStyle(fontSize: 10)),
              const SizedBox(height: 4),
              Container(
                width: 24,
                height: height.toDouble().clamp(4, 60),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F6D52),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(label,
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMainActionButtons(BuildContext context) {
    return Column(
      children: [
        _actionButton(context, "Setor Sampah Sekarang", true, '/setor_utama'),
        _actionButton(
            context, "Cari Drop Point Terdekat", false, '/setor_drop_point'),
        _actionButton(
            context, "Jadwalkan Penjemputan", false, '/setor_jemput'),
      ],
    );
  }

  Widget _actionButton(
      BuildContext context, String title, bool primary, String route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? const Color(0xFF1B3022) : Colors.white,
          foregroundColor: primary ? Colors.white : const Color(0xFF1B3022),
          side: const BorderSide(color: Color(0xFF1B3022)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildChallengeItem(String title, int progress, int total) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F1E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.eco, color: Color(0xFF4F6D52)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: total > 0 ? progress / total : 0,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.green,
                  minHeight: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$progress/$total",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int index) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1B3022),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      currentIndex: index,
      onTap: (newIndex) {
        if (newIndex == 0) {
          Navigator.pushReplacementNamed(context, '/setor_utama');
        } else if (newIndex == 1) {
          Navigator.pushReplacementNamed(context, '/challenge_aktif');
        } else if (newIndex == 2) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (newIndex == 3) {
          Navigator.pushReplacementNamed(context, '/reward_tukar');
        } else if (newIndex == 4) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.eco_outlined),
          label: "Deposit",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes),
          label: "Challenge",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events_outlined),
          label: "Reward",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
