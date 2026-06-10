import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_client.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (fullName.isEmpty || email.isEmpty || phone.isEmpty ||
        address.isEmpty || password.isEmpty) {
      _showSnackbar("Semua field harus diisi");
      return;
    }

    if (password.length < 8) {
      _showSnackbar("Password minimal 8 karakter");
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar("Password dan konfirmasi tidak cocok");
      return;
    }

    if (!_agreeTerms) {
      _showSnackbar("Harap setujui Syarat & Ketentuan");
      return;
    }

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.register(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
        address: address,
      );

      if (!mounted) return;
      // Navigate to OTP page with phone number
      Navigator.pushNamed(context, '/otp', arguments: {
        'phone': phone,
        'email': email,
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      _showSnackbar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackbar("Gagal terhubung ke server");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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

              _buildTextField("Nama Lengkap", "Masukkan nama lengkap",
                  controller: _fullNameController),
              _buildTextField("Email", "Masukkan Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress),
              _buildTextField("Nomor Handphone", "Masukkan Nomor Handphone",
                  controller: _phoneController,
                  keyboardType: TextInputType.phone),
              _buildTextField("Alamat", "Masukkan Alamat",
                  controller: _addressController),
              _buildTextField(
                "Password",
                "Masukkan Password",
                isPassword: true,
                controller: _passwordController,
              ),
              _buildTextField(
                "Konfirmasi Password",
                "Masukkan Password",
                isPassword: true,
                controller: _confirmPasswordController,
              ),

              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (val) {
                      setState(() {
                        _agreeTerms = val ?? false;
                      });
                    },
                  ),
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
                  onPressed: authProvider.isLoading ? null : _handleRegister,
                  child: authProvider.isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
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

  Widget _buildTextField(String label, String hint, {
    bool isPassword = false,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
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
