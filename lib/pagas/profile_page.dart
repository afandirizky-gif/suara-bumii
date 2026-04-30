import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      body: SingleChildScrollView(
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
                // Lokasi: profile_page.dart bagian header profil
                Stack(
                  children: [
         CircleAvatar(
       radius: 50,
      backgroundColor: Colors.white,
      // PAKAI child, BUKAN icon
      child: const Icon(Icons.person, size: 50, color: Colors.grey),
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
    )
  ],
),
                  const SizedBox(height: 15),
                  const Text(
                    "PUTRA SAPUTRA",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.eco, color: Colors.white, size: 14),
                      Text(" Eco Warrior - Level 5", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Progress Bar Level
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.white.withOpacity(0.3),
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
                  // Row Stats (Poin, Streak, Total Stor)
                  Row(
                    children: [
                      _buildMiniStatCard("2400", "Poin", Icons.emoji_events_outlined, const Color(0xFFE8F3E9)),
                      const SizedBox(width: 10),
                      _buildMiniStatCard("12", "hari streak", Icons.local_fire_department, const Color(0xFFFFF4E6)),
                      const SizedBox(width: 10),
                      _buildMiniStatCard("28", "total stor", Icons.inventory_2_outlined, const Color(0xFFF1F1F1)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Row Impact (CO2 & Jumlah Setor)
                  Row(
                    children: [
                      _buildImpactCard("CO2 Bulan Ini", "8.3 kg dicegah"),
                      const SizedBox(width: 15),
                      _buildImpactCard("Jumlah Setor", "14x bulan ini"),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Green Info Badges
                  Row(
                    children: [
                      _buildGreenBadge("4 pohon"),
                      const SizedBox(width: 10),
                      _buildGreenBadge("230L air"),
                      const SizedBox(width: 10),
                      _buildGreenBadge("18kwh"),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Menu List
                  _buildMenuItem(Icons.person_outline, "Data User"),
                  _buildMenuItem(Icons.history, "Riwayat Stor Sampah"),
                  _buildMenuItem(Icons.eco_outlined, "Statistik Dampak Lingkungan"),
                  _buildMenuItem(Icons.notifications_none, "Notifikasi", trailing: "🔔"),
                  _buildMenuItem(Icons.settings_outlined, "Settings"),
                  const SizedBox(height: 10),
                  
                  _buildMenuItem(Icons.help_outline, "Bantuan & FAQ", isDark: true),
                  
                  const SizedBox(height: 10),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
                      icon: const Icon(Icons.logout, color: Colors.grey),
                      label: const Text("Logout", style: TextStyle(color: Colors.black)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFEBEBE4),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
     bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  backgroundColor: const Color(0xFF1B3022),
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white60,
  currentIndex: 4, // Tetap 4 karena ini halaman Profil
  
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
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ],
),
    );
  }

  // Widget-widget pembantu
  Widget _buildMiniStatCard(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(height: 5),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactCard(String title, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildGreenBadge(String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFF1B3022), borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11))),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailing, bool isDark = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF3D5543) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isDark ? Colors.white : Colors.black54),
        title: Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14)),
        trailing: trailing != null 
          ? Text(trailing) 
          : Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.grey),
      ),
    );
  }
}