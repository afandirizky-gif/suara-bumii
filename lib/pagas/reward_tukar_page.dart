import 'package:flutter/material.dart';

class RewardTukarPage extends StatelessWidget {
  const RewardTukarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
     appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3022)),
        onPressed: () {
      Navigator.pushReplacementNamed(context, '/home');
      },
   ),
  title: const Text("Tukar Reward", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
  centerTitle: true,
  backgroundColor: Colors.transparent,
  elevation: 0,
),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPointHeader(),
            const SizedBox(height: 20),
            _buildTabBar(context, 0),
            const SizedBox(height: 20),
            
            // Input Jumlah Poin
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Masukkan Jumlah Poin", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "0",
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B3022), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/reward_riwayat_page');
                        Navigator.pushReplacementNamed(context, '/reward_referral_page');
                      },
                      child: const Text("Tukar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Pilihan E-Wallet
            _buildWalletOption("Gopay", "Transfer ke Gopay", "G"),
            _buildWalletOption("Ovo", "Transfer ke Ovo", "O"),
            _buildWalletOption("Dana", "Transfer ke Dana", "D"),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 3),
    );
  }

  // Widget Helper Header Poin (Sama untuk semua halaman Reward)
  Widget _buildPointHeader() {
    return Column(
      children: [
        const Icon(Icons.circle, color: Colors.orange, size: 50),
        const Text("2,450", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        const Text("Total Poin", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const Text("Butuh 550 poin lagi untuk reward Rp 25.000", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey.shade200, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabItem(context, "Aktif", index == 0, '/reward_tukar'),
        _tabItem(context, "Tersedia", index == 1, '/reward_riwayat'),
        _tabItem(context, "Selesai", index == 2, '/reward_referral'),
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
// Copy dari sini min
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
  Widget _buildWalletOption(String name, String sub, String initial) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.grey.shade100, child: Text(initial, style: const TextStyle(color: Colors.black))),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}