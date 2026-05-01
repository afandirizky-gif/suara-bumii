import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selamat datang,",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "Putra Pratama", 
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B3022),
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=11',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Streak: 12 hari berturut-turut",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildScanBanner(context),
              const SizedBox(height: 20),
              _buildPointCard(),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildStatCard("CO2 Bulan Ini", "8.3 kg dicegah"),
                  const SizedBox(width: 15),
                  _buildStatCard("Jumlah Setor", "14x bulan ini"),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Aktivitas Setor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3022),
                ),
              ),
              const SizedBox(height: 12),
              _buildActivityGraph(),
              const SizedBox(height: 20),
              _buildMainActionButtons(),
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Challenge Aktif",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B3022),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Lihat Semua >",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ),
                ],
              ),
              _buildChallengeItem("Kumpulkan 10 Botol Plastik", 7, 10),
              _buildChallengeItem("Kumpulkan 10 Botol Plastik", 7, 10),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1B3022),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        currentIndex: 2, 
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/setor_utama');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/challenge_aktif');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/reward_tukar');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_outlined),
            label: "Deposit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Challenge",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: "Reward",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildScanBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/scan_sampah');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1B3022),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_center_focus, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Scan Sampah dengan AI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Point kamu", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "2,450",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.circle,
                color: Colors.orange.shade300,
                size: 30,
              ), // Placeholder koin
            ],
          ),
          const Text(
            "+150 poin minggu ini >",
            style: TextStyle(color: Colors.green, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityGraph() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bar_chart, color: Colors.green, size: 30),
          Text(
            "Grafik Aktivitas",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMainActionButtons() {
    return Column(
      children: [
        _actionButton("Setor Sampah Sekarang", true),
        _actionButton("Cari Drop Point Terdekat", false),
        _actionButton("Jadwalkan Penjemputan", false),
      ],
    );
  }

  Widget _actionButton(String title, bool primary) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? const Color(0xFF1B3022) : Colors.white,
          foregroundColor: primary ? Colors.white : const Color(0xFF1B3022),
          side: const BorderSide(color: Color(0xFF1B3022)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildChallengeItem(String title, int progress, int total) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F1E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.eco, color: Color(0xFF4F6D52)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress / total,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.green,
                  minHeight: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$progress/$total",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
