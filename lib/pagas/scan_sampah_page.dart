import 'package:flutter/material.dart';

class ScanSampahPage extends StatelessWidget {
  const ScanSampahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        title: const Text(
          "Pilah Sampah",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Area Kamera / Preview Gambar
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
              // Ganti bagian Row ini di dalam body:
                  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      _buildCategoryTab(Icons.eco_outlined, "Organik", false), // Pakai eco_outlined
                      _buildCategoryTab(Icons.recycling, "Anorganik", true), 
                      _buildCategoryTab(Icons.report_problem_outlined, "B3", false), // Pakai report_problem
                    ],
                ),   
            const SizedBox(height: 20),

            // Card Hasil AI
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "AI Result",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "● 94.5% akurat",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Botol Plastik PET",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildInfoSmall("CO2 Dicegah", "0.3 kg"),
                      const SizedBox(width: 10),
                      _buildInfoSmall("Poin Didapat", "+50"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Cara Penanganan
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.eco, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Cara Penanganan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildStep(1, "Kosongkan dan bilas botol dari sisa cairan"),
                  _buildStep(2, "Lepaskan label dan tutup botol (pisahkan)"),
                  _buildStep(3, "Remas botol untuk menghemat ruang"),
                  _buildStep(
                    4,
                    "Masukkan ke tempat sampah anorganik atau drop point terdekat",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Tombol Lanjut
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3022),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Text(
                  "Lanjut Setor",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                label: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Hasil kurang tepat? Koreksi manual",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(
        context,
        0,
      ), // Index 0 untuk Deposit/Scan
    );
  }

  // Widget-widget Helper
  Widget _buildCategoryTab(IconData icon, String label, bool isActive) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isActive ? Border.all(color: Colors.black12, width: 2) : null,
        boxShadow: isActive
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]
            : null,
      ),
      child: Column(
        children: [
          Icon(icon, color: isActive ? Colors.green : Colors.black),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSmall(String title, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F1E6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.green,
            child: Text(
              num.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
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
        if (newIndex == 1) {
          Navigator.pushReplacementNamed(context, '/challenge_aktif');
        }
        if (newIndex == 3) {
          Navigator.pushReplacementNamed(context, '/reward_tukar');
        }
        if (newIndex == 4) Navigator.pushReplacementNamed(context, '/profile');
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
    );
  }
}
