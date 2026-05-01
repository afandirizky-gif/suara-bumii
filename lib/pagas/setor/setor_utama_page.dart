import 'package:flutter/material.dart';

class SetorUtamaPage extends StatelessWidget {
  const SetorUtamaPage({super.key});

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
                _buildMethodCard(
                  context,
                  "Jemput",
                  Icons.inventory_2_outlined,
                  '/setor_jemput',
                ),
                const SizedBox(width: 15),
                _buildMethodCard(
                  context,
                  "Drop Point",
                  Icons.location_on_outlined,
                  '/setor_drop_point',
                ),
              ],
            ),
            const SizedBox(height: 35),
            _buildRecentDepositsHeader(),
            const SizedBox(height: 15),
            _buildStatRow(),
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "Setor Sampah",
        style: TextStyle(
          fontFamily: 'Serif',
          fontWeight: FontWeight.bold,
          color: Color(0xFF1B3022),
          fontSize: 26,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildMethodCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: const Color(0xFF1B3022)),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentDepositsHeader() {
    return Row(
      children: [
        const Icon(
          Icons.calendar_today_outlined,
          size: 18,
          color: Color(0xFF1B3022),
        ),
        const SizedBox(width: 8),
        const Text(
          "Recent Deposits",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildStatRow() {
    return Row(
      children: [
        _buildStatCard("Plastic", "2.5 kg", "Today", Colors.blue),
        const SizedBox(width: 10),
        _buildStatCard("Paper", "3.2 kg", "Yesterday", Colors.orange),
        const SizedBox(width: 10),
        _buildStatCard("Metal", "1.8 kg", "2 Days ago", Colors.grey),
      ],
    );
  }

  Widget _buildStatCard(String label, String val, String date, Color col) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: col,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            Text(
              val,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(date, style: const TextStyle(color: Colors.grey, fontSize: 9)),
          ],
        ),
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
        // Jangan lupa tambahin navigasinya min biar bisa diklik!
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
