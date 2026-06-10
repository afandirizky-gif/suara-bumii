import 'package:flutter/material.dart';
import '../services/pickup_service.dart';
import '../services/api_client.dart';

class SetorJemputPage extends StatefulWidget {
  const SetorJemputPage({super.key});

  @override
  State<SetorJemputPage> createState() => _SetorJemputPageState();
}

class _SetorJemputPageState extends State<SetorJemputPage> {
  List<dynamic> _pickups = [];
  bool _isLoading = true;
  bool _isCreating = false;

  final _addressController = TextEditingController();
  final _weightController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final data = await pickupService.getPickups();
      if (mounted) setState(() { _pickups = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createPickup() async {
    final address = _addressController.text.trim();
    final weightText = _weightController.text.trim();

    if (address.isEmpty || weightText.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi semua field"), backgroundColor: Colors.red),
      );
      return;
    }

    final weight = double.tryParse(weightText);
    if (weight == null || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berat tidak valid"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isCreating = true);
    try {
      await pickupService.createPickup(
        address: address,
        scheduledAt: _selectedDate!.toIso8601String(),
        estimatedWeightKg: weight,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Penjemputan dijadwalkan!"), backgroundColor: Colors.green),
      );
      _addressController.clear();
      _weightController.clear();
      setState(() => _selectedDate = null);
      _loadData();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal membuat jadwal"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isCreating = false);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pilih cara setor yang paling mudah untukmu",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Form Buat Jadwal
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Buat Jadwal Penjemputan",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: "Alamat penjemputan",
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Estimasi berat (kg)",
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _selectedDate != null
                            ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                            : "Pilih tanggal penjemputan",
                        style: TextStyle(
                            color: _selectedDate != null
                                ? Colors.black
                                : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Jadwal Penjemputan
            const Text("Jadwal Penjemputan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (!_isLoading && _pickups.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Belum ada jadwal", style: TextStyle(color: Colors.grey)),
                ),
              ),
            ..._pickups.map((p) {
              final scheduledAt = p['scheduledAt']?.toString() ?? '';
              final dateStr = scheduledAt.length >= 10
                  ? scheduledAt.substring(0, 10)
                  : scheduledAt;
              final status = p['status'] ?? 'scheduled';
              return _buildScheduleItem(dateStr, status);
            }),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _isCreating ? null : _createPickup,
                icon: _isCreating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.inventory_2_outlined,
                        color: Colors.white),
                label: Text(
                    _isCreating ? "Memproses..." : "Konfirmasi Penjemputan",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3022),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String date, String status) {
    Color statusColor;
    switch (status) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'in_transit':
        statusColor = Colors.blue;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Row(children: [
              Text(date,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(status,
                      style: TextStyle(
                          fontSize: 9, color: statusColor)))
            ]),
          ]),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}