import 'package:flutter/material.dart';

class RewardReferralPage extends StatelessWidget {
  const RewardReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3022)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/reward_tukar_page');
          },
        ),
        title: const Text("Referral Reward", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Kode Unik Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  const Text("Kode Unikmu", style: TextStyle(color: Colors.grey)),
                  const Text("PUTRA24", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: _actionBtn(Icons.copy, "Salin")),
                      const SizedBox(width: 10),
                      Expanded(child: _actionBtn(Icons.share, "Bagikan")),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Statistik Teman
            Row(
              children: [
                _statBox("Teman Diajak", "8"),
                const SizedBox(width: 10),
                _statBox("Poin Bonus", "1,600", color: Colors.green),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 3),
    );
  }
// Copy dari sini min
  Widget _buildBottomNav(BuildContext context, int index) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1B3022),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      currentIndex: index, // Index 3 untuk Reward
      onTap: (newIndex) {
        if (newIndex == 2) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (newIndex == 4) {
          Navigator.pushReplacementNamed(context, '/profile');
        } else if (newIndex == 3) {
          Navigator.pushReplacementNamed(context, '/reward_tukar');
        } else if (newIndex == 1) {
          Navigator.pushReplacementNamed(context, '/challenge_aktif');
        } else if (newIndex == 0) {
          Navigator.pushReplacementNamed(context, '/setor_utama');
        }
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
  Widget _actionBtn(IconData icon, String label) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3D5543), foregroundColor: Colors.white),
      onPressed: () {},
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