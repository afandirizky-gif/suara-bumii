import 'package:flutter/material.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("2/3", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text("Lewati", style: TextStyle(color: Color(0xFF4F6D52))),
                  ),
                ],
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://picsum.photos/301/400',
                  height: 300, width: double.infinity, fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Dapatkan E - Wallet Rewards",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B3022)),
              ),
              const SizedBox(height: 16),
              const Text(
                "Kumpulkan poin dari setiap sampah yang kamu setorkan dan tukarkan dengan saldo e-wallet favoritmu seperti GoPay, OVO, dan DANA.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Container(width: 20, height: 8, decoration: BoxDecoration(color: const Color(0xFF4F6D52), borderRadius: BorderRadius.circular(4))),
                  const SizedBox(width: 4),
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B3022), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => Navigator.pushNamed(context, '/onboarding_three'),
                  child: const Text("Lanjut", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}