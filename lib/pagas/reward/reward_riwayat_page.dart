import 'package:flutter/material.dart';

class RewardRiwayatPage extends StatelessWidget {
  const RewardRiwayatPage({super.key});

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
        title: const Text("Riwayat Reward", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text("Maret 2025", style: TextStyle(fontWeight: FontWeight.bold)),
             _buildHistoryItem("Tukar 500 poin ke Gopay", "-500", "29 Mar", isRed: true),
             _buildHistoryItem("Bonus Referral dari Ahmad", "+200", "29 Mar", isRed: false),
             const SizedBox(height: 20),
             const Text("Februari 2025", style: TextStyle(fontWeight: FontWeight.bold)),
             _buildHistoryItem("Tukar 300 poin ke Ovo", "-300", "29 Feb", isRed: true),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 3),
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
