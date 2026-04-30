import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Buat Akun Tunas",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3022),
                ),
              ),
              const Text("Mulai berkontribusi untuk lingkungan."),
              const SizedBox(height: 32),

              _buildTextField("Username", "Masukkan Username"),
              _buildTextField(
                "Password",
                "Masukkan Password",
                isPassword: true,
              ),
              _buildTextField("Email", "Masukkan Email"),
              _buildTextField(
                "Nomor Handphone",
                "Masukkan Nomor Handphone",
                isPassword: true,
              ),
              _buildTextField(
                "Konfirmasi Password",
                "Masukkan Password",
                isPassword: true,
              ),

              Row(
                children: [
                  Checkbox(value: false, onChanged: (val) {}),
                  const Expanded(
                    child: Text(
                      "Saya setuju dengan Syarat & Ketentuan dan Kebijakan Privasi",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F6D52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                 onPressed: () {
                       // Dia akan mencari rute '/otp' yang ada di main.dart tadi
                         Navigator.pushNamed(context, '/otp');},
                  child: const Text(
                    "Daftar Sekarang",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: isPassword
                  ? const Icon(Icons.visibility_outlined)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
