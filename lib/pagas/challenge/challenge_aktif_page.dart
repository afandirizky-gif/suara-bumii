import 'package:flutter/material.dart';

class ChallengeAktifPage extends StatelessWidget {
  const ChallengeAktifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        title: const Text("Challenge", style: TextStyle(fontFamily: 'Serif', fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(context, 0),
            const SizedBox(height: 20),
            // Banner Unggulan
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1B3022), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🔥 Challenge Unggulan", style: TextStyle(color: Colors.white, fontSize: 10)),
                  const Text("Pilah 10 kg Minggu Ini", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text("128 orang bergabung • Berakhir dalam 2 hari", style: TextStyle(color: Colors.white70, fontSize: 10)),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(value: 0.6, backgroundColor: Colors.white24, color: Colors.green),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    child: const Text("Buat Sekarang", style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            _buildChallengeItem("Bike to Work", "Use bicycle for commute", "2/5", "5 days", "+ 400 pts"),
            _buildChallengeItem("Bike to Work", "Use bicycle for commute", "2/5", "5 days", "+ 400 pts"),
            const SizedBox(height: 25),
            const Text("Badges", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildBadgeGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 1),
    );
  }

  // Widget Helper Tab Bar
  Widget _buildTabBar(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabItem(context, "Aktif", index == 0, '/challenge_aktif'),
        _tabItem(context, "Tersedia", index == 1, '/challenge_tersedia'),
        _tabItem(context, "Selesai", index == 2, '/challenge_selesai'),
      ],
    );
  }

  Widget _tabItem(BuildContext context, String label, bool isActive, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1B3022) : const Color(0xFF6DA472),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildChallengeItem(String title, String sub, String progress, String days, String pts) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text("$days  $pts", style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFFE8F3E9), shape: BoxShape.circle),
            child: Text(progress, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey)
        ],
      ),
    );
  }

  Widget _buildBadgeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: 8,
      itemBuilder: (context, index) => Container(decoration: BoxDecoration(color: const Color(0xFFD9B3B3), borderRadius: BorderRadius.circular(12))),
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
        if (newIndex == 2) Navigator.pushReplacementNamed(context, '/home');
        if (newIndex == 3) Navigator.pushReplacementNamed(context, '/reward_tukar');
        if (newIndex == 4) Navigator.pushReplacementNamed(context, '/profile');
        if (newIndex == 1) Navigator.pushReplacementNamed(context, '/challenge_aktif');
        if (newIndex == 0) Navigator.pushReplacementNamed(context, '/setor_utama');
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