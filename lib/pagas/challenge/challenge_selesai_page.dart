import 'package:flutter/material.dart';

class ChallengeSelesaiPage extends StatelessWidget {
  const ChallengeSelesaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        title: const Text(
          "Challenge",
          style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Color(0xFF1B3022)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Bar - Selesai aktif (Index 2)
            _buildTabBar(context, 2),
            const SizedBox(height: 25),

            const Text("Maret 2025", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildFinishedItem("Bike to Work", "5 days", "+ 400 pts"),
            _buildFinishedItem("Bike to Work", "5 days", "+ 400 pts"),
            const SizedBox(height: 25),

            const Text("April 2025", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildFinishedItem("Bike to Work", "5 days", "+ 400 pts"),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 1), // Index 1 untuk icon Challenge
    );
  }

  // --- FUNGSI HELPER (Ditaruh di dalam class tapi di luar build) ---

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

  Widget _buildFinishedItem(String title, String days, String pts) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text("Use bicycle for commute", style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 5),
                Text("$days  $pts", style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 15, 
            backgroundColor: Color(0xFFE8F3E9), 
            child: Text("2/5", style: TextStyle(fontSize: 10, color: Colors.green))
          ),
          const Icon(Icons.chevron_right, color: Colors.grey)
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
        if (newIndex == 2) Navigator.pushReplacementNamed(context, '/home');
        if (newIndex == 3) Navigator.pushReplacementNamed(context, '/reward_tukar');
        if (newIndex == 4) Navigator.pushReplacementNamed(context, '/profile');
        if (newIndex == 1) Navigator.pushReplacementNamed(context, '/challenge_aktif');
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