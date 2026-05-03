import 'package:flutter/material.dart';
import 'auth/authentication_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1E6),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F1E6),
                ),
                child: Image.asset(
                  'assets/images/logo figma.png',
                  width: 220,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Text(
                "Pilah sampah lebih mudah, dapat reward nyata, dan lihat dampakmu bagi bumi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 56, 25),
                  fontSize: 14,
                ),
              ),
            ),

            const Spacer(),

            // Tombol Lanjut
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

            // Versi Aplikasi
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
