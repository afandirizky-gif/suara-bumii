import 'package:flutter/material.dart';
import '../services/drop_point_service.dart';

class SetorDropPointPage extends StatefulWidget {
  const SetorDropPointPage({super.key});

  @override
  State<SetorDropPointPage> createState() => _SetorDropPointPageState();
}

class _SetorDropPointPageState extends State<SetorDropPointPage> {
  List<dynamic> _dropPoints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await dropPointService.getDropPoints();
      if (mounted) setState(() { _dropPoints = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        title: const Text("Setor Sampah",
            style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Text("Pilih cara setor yang paling mudah untukmu",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          // MAP AREA
          Container(
            height: 220,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                const Center(
                    child: Icon(Icons.map_outlined,
                        size: 50, color: Colors.blue)),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: const Text("📍 Lokasi Kamu",
                            style: TextStyle(fontSize: 10)))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Drop Point Terdekat",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            Text("${_dropPoints.length} lokasi",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _dropPoints.length,
                            itemBuilder: (context, index) {
                              final dp = _dropPoints[index];
                              final isOpen = dp['isOpen'] ?? false;
                              return _buildLocationItem(
                                dp['name'] ?? '',
                                dp['address'] ?? '',
                                dp['distanceKm'] != null
                                    ? "${dp['distanceKm']} km"
                                    : '-',
                                isOpen ? "Buka" : "Tutup",
                                isOpen ? Colors.green : Colors.red,
                                dp['rating']?.toString() ?? '-',
                                dp['openTime'] ?? '',
                                dp['closeTime'] ?? '',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItem(String name, String addr, String dist,
      String status, Color col, String rating, String openTime, String closeTime) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.green),
          const SizedBox(width: 15),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(addr,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                Text("$dist • $rating ⭐ 🕗 $openTime - $closeTime",
                    style: const TextStyle(fontSize: 10)),
              ])),
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: col.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(status,
                  style: TextStyle(
                      color: col,
                      fontWeight: FontWeight.bold,
                      fontSize: 10))),
        ],
      ),
    );
  }
}