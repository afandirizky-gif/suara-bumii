import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/referral_service.dart';

class RewardReferralPage extends StatefulWidget {
  const RewardReferralPage({super.key});

  @override
  State<RewardReferralPage> createState() => _RewardReferralPageState();
}

class _RewardReferralPageState extends State<RewardReferralPage> {
  Map<String, dynamic>? _stats;
  String? _code;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final stats = await referralService.getStats();
      if (mounted) {
        setState(() {
          _stats = stats;
          _code = stats['code'] as String?;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final invited = _stats?['invited'] ?? 0;
    final bonusTotal = _stats?['totalBonusPoints'] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3022)),
          onPressed: () => Navigator.pushReplacementNamed(context, '/reward_tukar'),
        ),
        title: const Text("Referral Reward", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTabBar(context, 2),
                  const SizedBox(height: 20),
                  // Kode Unik Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        const Text("Kode Unikmu", style: TextStyle(color: Colors.grey)),
                        Text(
                          _code ?? '-',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: _actionBtn(Icons.copy, "Salin", () {
                              if (_code != null) {
                                Clipboard.setData(ClipboardData(text: _code!));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Kode disalin!"), duration: Duration(seconds: 1)),
                                );
                              }
                            })),
                            const SizedBox(width: 10),
                            Expanded(child: _actionBtn(Icons.share, "Bagikan", () {})),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Statistik Teman
                  Row(
                    children: [
                      _statBox("Teman Diajak", "$invited"),
                      const SizedBox(width: 10),
                      _statBox("Poin Bonus", "$bonusTotal", color: Colors.green),
                    ],
                  ),
                  // Referral list
                  if (_stats?['referrals'] != null) ...[
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Daftar Referral", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(height: 10),
                    ...(_stats!['referrals'] as List<dynamic>).map((r) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE8F3E9),
                          child: Icon(Icons.person, color: Color(0xFF4F6D52)),
                        ),
                        title: Text(r['name'] ?? '-'),
                        subtitle: Text("+${r['bonusPoints']} poin", style: const TextStyle(color: Colors.green, fontSize: 12)),
                      );
                    }),
                  ],
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNav(context, 3),
    );
  }

  Widget _buildTabBar(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabItem(context, "Tukar", index == 0, '/reward_tukar'),
        _tabItem(context, "Riwayat", index == 1, '/reward_riwayat'),
        _tabItem(context, "Referral", index == 2, '/reward_referral'),
      ],
    );
  }

  Widget _tabItem(BuildContext context, String label, bool isActive, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF3D5543) : const Color(0xFF6DA472),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        if (newIndex == 0) Navigator.pushReplacementNamed(context, '/setor_utama');
        if (newIndex == 1) Navigator.pushReplacementNamed(context, '/challenge_aktif');
        if (newIndex == 2) Navigator.pushReplacementNamed(context, '/home');
        if (newIndex == 3) Navigator.pushReplacementNamed(context, '/reward_tukar');
        if (newIndex == 4) Navigator.pushReplacementNamed(context, '/profile');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.eco_outlined), label: "Deposit"),
        BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: "Challenge"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), label: "Reward"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3D5543), foregroundColor: Colors.white),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }

  Widget _statBox(String label, String val, {Color color = Colors.black}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}