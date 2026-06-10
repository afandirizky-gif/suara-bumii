import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _profile;
  Map<String, dynamic>? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        profileService.getProfile(),
        profileService.getStats(),
      ]);
      if (mounted) {
        setState(() {
          _profile = results[0];
          _stats = results[1];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userName = _profile?['fullName'] ?? authProvider.userName;
    final rank = _profile?['rank'] ?? 'Eco Warrior';
    final totalPoints = _stats?['totalPoints'] ?? 0;
    final totalWeight = _stats?['totalWeightKg'] ?? 0;
    final activeDays = _stats?['activeDays'] ?? 0;
    final challengesCompleted = _stats?['challengesCompleted'] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Header Hijau
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 60, bottom: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFF6DA472),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person,
                                  size: 50, color: Colors.grey),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(0xFF8DC491),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          userName.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.eco,
                                color: Colors.white, size: 14),
                            Text(" $rank",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 0.6,
                              backgroundColor: Colors.white.withValues(alpha: 0.3),
                              color: Colors.white,
                              minHeight: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Row Stats
                        Row(
                          children: [
                            _buildMiniStatCard("$totalPoints", "Poin",
                                Icons.emoji_events_outlined,
                                const Color(0xFFE8F3E9)),
                            const SizedBox(width: 10),
                            _buildMiniStatCard("$activeDays", "hari aktif",
                                Icons.local_fire_department,
                                const Color(0xFFFFF4E6)),
                            const SizedBox(width: 10),
                            _buildMiniStatCard("$challengesCompleted",
                                "challenge",
                                Icons.inventory_2_outlined,
                                const Color(0xFFF1F1F1)),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Row Impact
                        Row(
                          children: [
                            _buildImpactCard("Total Berat",
                                "$totalWeight kg didaur ulang"),
                            const SizedBox(width: 15),
                            _buildImpactCard("Poin Total",
                                "$totalPoints poin"),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Menu List
                        _buildMenuItem(Icons.person_outline, "Data User"),
                        _buildMenuItem(
                            Icons.history, "Riwayat Stor Sampah"),
                        _buildMenuItem(Icons.eco_outlined,
                            "Statistik Dampak Lingkungan"),
                        _buildMenuItem(Icons.notifications_none,
                            "Notifikasi",
                            trailing: "🔔"),
                        _buildMenuItem(Icons.settings_outlined, "Settings"),
                        const SizedBox(height: 10),

                        _buildMenuItem(Icons.help_outline, "Bantuan & FAQ",
                            isDark: true),

                        const SizedBox(height: 10),
                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await authProvider.logout();
                              if (!context.mounted) return;
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            },
                            icon: const Icon(Icons.logout, color: Colors.grey),
                            label: const Text("Logout",
                                style: TextStyle(color: Colors.black)),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFEBEBE4),
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNav(context, 4),
    );
  }

  Widget _buildMiniStatCard(
      String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(height: 5),
            Text(val,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(label,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactCard(String title, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(val,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,
      {String? trailing, bool isDark = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF3D5543) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading:
            Icon(icon, color: isDark ? Colors.white : Colors.black54),
        title: Text(title,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 14)),
        trailing: trailing != null
            ? Text(trailing)
            : Icon(Icons.chevron_right,
                color: isDark ? Colors.white : Colors.grey),
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
        }
        if (newIndex == 1) {
          Navigator.pushReplacementNamed(context, '/challenge_aktif');
        }
        if (newIndex == 2) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (newIndex == 3) {
          Navigator.pushReplacementNamed(context, '/reward_tukar');
        }
        if (newIndex == 4) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.eco_outlined), label: "Deposit"),
        BottomNavigationBarItem(
            icon: Icon(Icons.track_changes), label: "Challenge"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined), label: "Reward"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}