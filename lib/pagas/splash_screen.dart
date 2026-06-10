import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/authentication_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Small delay for splash branding
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loggedIn = await authProvider.tryAutoLogin();

    if (!mounted) return;

    if (loggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
    // If not logged in, stay on splash screen and let user tap to continue
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6), // Warna krem sesuai gambar
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Logo Daun (Sudah diperbaiki strukturnya)
            Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  color: Color(0xFF6B9B78),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco, // Pakai eco biar aman
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Nama Aplikasi
            const Text(
              "Suara Bumi",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B3022),
              ),
            ),

            // Deskripsi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Text(
                "Pilah sampah lebih mudah, dapat reward nyata, dan lihat dampakmu bagi bumi.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF1B3022), fontSize: 14),
              ),
            ),

            const Spacer(),

            // Tombol Navigasi
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationPage(),
                  ),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tap untuk melanjutkan",
                    style: TextStyle(color: Color(0xFF1B3022)),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward, size: 18, color: Color(0xFF1B3022)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Versi
            const Text(
              "v1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
