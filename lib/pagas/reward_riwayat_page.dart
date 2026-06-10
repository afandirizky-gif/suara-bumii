import 'package:flutter/material.dart';
import '../services/reward_service.dart';

class RewardRiwayatPage extends StatefulWidget {
  const RewardRiwayatPage({super.key});

  @override
  State<RewardRiwayatPage> createState() => _RewardRiwayatPageState();
}

class _RewardRiwayatPageState extends State<RewardRiwayatPage> {
  List<dynamic> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final data = await rewardService.getHistory();
      if (mounted) setState(() { _history = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3022)),
          onPressed: () => Navigator.pushReplacementNamed(context, '/reward_tukar'),
        ),
        title: const Text("Riwayat Reward", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTabBar(context, 1),
                  const SizedBox(height: 20),
                  if (_history.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text("Belum ada riwayat", style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ..._history.map((item) {
                    final amount = item['amount'] as num? ?? 0;
                    final type = item['type'] ?? '';
                    final description = item['description'] ?? type;
                    final createdAt = item['createdAt'] ?? '';
                    final dateStr = createdAt.toString().length >= 10
                        ? createdAt.toString().substring(0, 10)
                        : createdAt.toString();
                    final isNegative = amount < 0;

                    return _buildHistoryItem(
                      description,
                      "${isNegative ? '' : '+'}$amount",
                      dateStr,
                      isRed: isNegative,
                    );
                  }),
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

  Widget _buildHistoryItem(String title, String point, String date, {bool isRed = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: const Text("Berhasil", style: TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(point, style: TextStyle(fontWeight: FontWeight.bold, color: isRed ? Colors.red : Colors.green)),
          Text(date, style: const TextStyle(fontSize: 10, color: Colors.grey)),
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
}
