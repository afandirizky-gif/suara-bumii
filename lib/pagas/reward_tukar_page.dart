import 'package:flutter/material.dart';
import '../services/reward_service.dart';
import '../services/api_client.dart';

class RewardTukarPage extends StatefulWidget {
  const RewardTukarPage({super.key});

  @override
  State<RewardTukarPage> createState() => _RewardTukarPageState();
}

class _RewardTukarPageState extends State<RewardTukarPage> {
  Map<String, dynamic>? _balance;
  bool _isLoading = true;
  bool _isRedeeming = false;
  String _selectedPlatform = 'gopay';

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    try {
      final data = await rewardService.getBalance();
      if (mounted) setState(() { _balance = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRedeem(int amountRp) async {
    setState(() => _isRedeeming = true);
    try {
      await rewardService.redeem(platform: _selectedPlatform, amountRp: amountRp);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Penukaran sedang diproses!"), backgroundColor: Colors.green),
      );
      _loadBalance(); // Refresh balance
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red.shade700),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menukar poin"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isRedeeming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final available = _balance?['available'] ?? 0;
    final nextReward = _balance?['nextReward'] as Map<String, dynamic>?;
    final progressPercent = nextReward?['progressPercent'] ?? 0;
    final pointsNeeded = nextReward?['pointsNeeded'] ?? 0;
    final nextAmountRp = nextReward?['nextAmountRp'] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3022)),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        title: const Text("Tukar Reward", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildPointHeader(available, progressPercent, pointsNeeded, nextAmountRp),
                  const SizedBox(height: 20),
                  _buildTabBar(context, 0),
                  const SizedBox(height: 20),
                  // Pilihan E-Wallet (tap to select)
                  _buildWalletOption("Gopay", "Transfer ke Gopay", "G", 'gopay'),
                  _buildWalletOption("Ovo", "Transfer ke Ovo", "O", 'ovo'),
                  _buildWalletOption("Dana", "Transfer ke Dana", "D", 'dana'),
                  const SizedBox(height: 20),
                  // Redeem buttons
                  const Text("Pilih Nominal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [5000, 10000, 25000, 50000].map((amount) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B3022),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _isRedeeming ? null : () => _handleRedeem(amount),
                          child: Text("Rp ${_formatNumber(amount)}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNav(context, 3),
    );
  }

  String _formatNumber(int n) {
    return n.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
  }

  Widget _buildPointHeader(int available, int progressPercent, int pointsNeeded, int nextAmountRp) {
    return Column(
      children: [
        const Icon(Icons.circle, color: Colors.orange, size: 50),
        Text("$available", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        const Text("Total Poin", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 15),
        if (nextAmountRp > 0)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Text("Butuh $pointsNeeded poin lagi untuk reward Rp ${_formatNumber(nextAmountRp)}", style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progressPercent / 100, backgroundColor: Colors.grey.shade200, color: Colors.green),
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
        _tabItem(context, "Tukar", index == 0, '/reward_tukar'),
        _tabItem(context, "Riwayat", index == 1, '/reward_riwayat'),
        _tabItem(context, "Referral", index == 2, '/reward_referral'),
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

  Widget _buildWalletOption(String name, String sub, String initial, String platform) {
    final isSelected = _selectedPlatform == platform;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlatform = platform),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: const Color(0xFF4F6D52), width: 2) : null,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isSelected ? const Color(0xFF4F6D52) : Colors.grey.shade100,
            child: Text(initial, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
          ),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
          trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF4F6D52)) : const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}