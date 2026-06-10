import 'package:flutter/material.dart';
import '../services/deposit_service.dart';

class SetorUtamaPage extends StatefulWidget {
  const SetorUtamaPage({super.key});

  @override
  State<SetorUtamaPage> createState() => _SetorUtamaPageState();
}

class _SetorUtamaPageState extends State<SetorUtamaPage> {
  List<dynamic> _recentDeposits = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await depositService.getHistory();
      if (mounted) setState(() { _recentDeposits = data.take(3).toList(); _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih cara setor yang paling mudah untukmu",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                _buildMethodCard(context, "Jemput", Icons.inventory_2_outlined, '/setor_jemput'),
                const SizedBox(width: 15),
                _buildMethodCard(context, "Drop Point", Icons.location_on_outlined, '/setor_drop_point'),
              ],
            ),
            const SizedBox(height: 35),
            _buildRecentDepositsHeader(),
            const SizedBox(height: 15),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildRecentList(),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Pilih metode penyetoran untuk melanjutkan",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 0),
    );
  }

  Widget _buildRecentList() {
    if (_recentDeposits.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text("Belum ada riwayat setor", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Row(
      children: _recentDeposits.map((d) {
        final weight = d['totalWeightKg'] ?? 0;
        final status = d['status'] ?? 'pending';
        final type = d['type'] ?? 'drop_point';
        final createdAt = d['createdAt']?.toString() ?? '';
        final dateStr = createdAt.length >= 10 ? createdAt.substring(0, 10) : createdAt;

        Color col;
        if (type == 'pickup') {
          col = Colors.orange;
        } else {
          col = Colors.blue;
        }

        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type == 'pickup' ? 'Jemput' : 'Drop Off',
                    style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 10)),
                Text("$weight kg", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(status, style: const TextStyle(color: Colors.grey, fontSize: 9)),
                Text(dateStr, style: const TextStyle(color: Colors.grey, fontSize: 8)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "Setor Sampah",
        style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Color(0xFF1B3022), fontSize: 26),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildMethodCard(BuildContext context, String title, IconData icon, String route) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 35),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Icon(icon, size: 40, color: const Color(0xFF1B3022)),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentDepositsHeader() {
    return const Row(
      children: [
        Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF1B3022)),
        SizedBox(width: 8),
        Text("Recent Deposits", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
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
