import 'package:flutter/material.dart';

class SetorJemputPage extends StatelessWidget {
  const SetorJemputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(title: const Text("Setor Sampah", style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Color(0xFF1B3022))), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pilih cara setor yang paling mudah untukmu", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            const Text("Jadwal Penjemputan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildScheduleItem("Senin, 31 Maret"),
            _buildScheduleItem("Senin, 31 Maret"),
            _buildScheduleItem("Senin, 31 Maret"),
            const SizedBox(height: 25),
            // RECENT DEPOSITS LAGI (Sesuai Gambar 3)
            const Row(children: [Icon(Icons.calendar_today_outlined, size: 16), SizedBox(width: 8), Text("Recent Deposits", style: TextStyle(fontWeight: FontWeight.bold))]),
            const SizedBox(height: 15),
            _buildStatRowSimulasi(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.inventory_2_outlined, color: Colors.white),
                label: const Text("Konfirmasi Penjemputan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B3022), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Text(date, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 10), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: const Text("Available", style: TextStyle(fontSize: 9, color: Colors.grey)))]),
            const Text("Slot: 09:00 - 12:00", style: TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildStatRowSimulasi() {
    return Row(children: [
      Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Plastic", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)), Text("2.5 kg", style: TextStyle(fontWeight: FontWeight.bold)), Text("Today", style: TextStyle(color: Colors.grey, fontSize: 9))]))),
      const SizedBox(width: 10),
      Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Paper", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)), Text("3.2 kg", style: TextStyle(fontWeight: FontWeight.bold)), Text("Yesterday", style: TextStyle(color: Colors.grey, fontSize: 9))]))),
      const SizedBox(width: 10),
      Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Metal", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10)), Text("1.8 kg", style: TextStyle(fontWeight: FontWeight.bold)), Text("2 Days ago", style: TextStyle(color: Colors.grey, fontSize: 9))]))),
    ]);
  }
}