import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF8CAF8D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    "Verifikasi Telepon",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("Masukkan kode yang kami kirim"),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text("Kami telah mengirim kode verifikasi ke"),
            const Text(
              "+62 812 3456 7890",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Ubah nomor HP",
                style: TextStyle(color: Color(0xFF4F6D52)),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Masukkan Kode OTP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => _buildOtpBox()),
            ),
            const SizedBox(height: 24),
            const Text("Kirim ulang kode dalam 00:58"),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Kirim Ulang Kode",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3022),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
               onPressed: () {
                             // Dia akan mencari rute '/profile_setup' di main.dart
              Navigator.pushNamed(context, '/profile_setup');},
                child: const Text(
                  "Verifikasi",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
