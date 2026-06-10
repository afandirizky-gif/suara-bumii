import 'package:flutter/material.dart';
import '../services/challenge_service.dart';
import '../services/api_client.dart';

class ChallengeAktifPage extends StatefulWidget {
  const ChallengeAktifPage({super.key});

  @override
  State<ChallengeAktifPage> createState() => _ChallengeAktifPageState();
}

class _ChallengeAktifPageState extends State<ChallengeAktifPage> {
  Map<String, dynamic>? _overview;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await challengeService.getOverview();
      if (mounted) setState(() { _overview = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _joinChallenge(String id) async {
    try {
      await challengeService.joinChallenge(id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil bergabung!"), backgroundColor: Colors.green),
      );
      _loadData(); // Refresh
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final featured = _overview?['featuredChallenge'] as Map<String, dynamic>?;
    final active = _overview?['activeChallenges'] as List<dynamic>? ?? [];
    final badges = _overview?['badges'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      appBar: AppBar(
        title: const Text("Challenge", style: TextStyle(fontFamily: 'Serif', fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTabBar(context, 0),
                  const SizedBox(height: 20),
                  // Banner Unggulan
                  if (featured != null) _buildFeaturedBanner(featured),
                  const SizedBox(height: 25),
                  if (active.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text("Belum ada challenge aktif", style: TextStyle(color: Colors.grey))),
                    ),
                  ...active.map((c) => _buildChallengeItem(
                    c['title'] ?? '',
                    c['description'] ?? '',
                    "${c['progress'] ?? 0}/${c['target'] ?? 0}",
                    "${c['durationDays'] ?? 0} days",
                    "+ ${c['rewardPoints'] ?? 0} pts",
                  )),
                  const SizedBox(height: 25),
                  const Text("Badges", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildBadgeGrid(badges),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNav(context, 1),
    );
  }

  Widget _buildFeaturedBanner(Map<String, dynamic> featured) {
    final progress = featured['progressPercent'] ?? 0;
    final joined = featured['joined'] ?? false;
    final joinedCount = featured['joinedCount'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1B3022), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🔥 Challenge Unggulan", style: TextStyle(color: Colors.white, fontSize: 10)),
          Text(featured['title'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text("$joinedCount orang bergabung", style: const TextStyle(color: Colors.white70, fontSize: 10)),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(value: progress / 100, backgroundColor: Colors.white24, color: Colors.green),
          ),
          const SizedBox(height: 15),
          if (!joined)
            ElevatedButton(
              onPressed: () => _joinChallenge(featured['id']),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
              child: const Text("Ikut Sekarang", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          else
            const Text("✓ Sudah bergabung", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _tabItem(context, "Aktif", index == 0, '/challenge_aktif'),
        _tabItem(context, "Tersedia", index == 1, '/challenge_tersedia'),
        _tabItem(context, "Selesai", index == 2, '/challenge_selesai'),
      ],
    );
  }

  Widget _tabItem(BuildContext context, String label, bool isActive, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1B3022) : const Color(0xFF6DA472),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildChallengeItem(String title, String sub, String progress, String days, String pts) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text("$days  $pts", style: const TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFFE8F3E9), shape: BoxShape.circle),
            child: Text(progress, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 11)),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey)
        ],
      ),
    );
  }

  Widget _buildBadgeGrid(List<dynamic> badges) {
    if (badges.isEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: 8,
        itemBuilder: (context, index) => Container(decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12))),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        final badge = badges[index];
        final active = badge['active'] ?? false;
        return Container(
          decoration: BoxDecoration(
            color: active ? const Color(0xFF4F6D52) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(badge['icon'] ?? '🏆', style: const TextStyle(fontSize: 20)),
                Text(badge['name'] ?? '', style: TextStyle(fontSize: 8, color: active ? Colors.white : Colors.grey), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
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