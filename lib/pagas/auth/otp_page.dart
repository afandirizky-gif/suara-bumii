import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/api_client.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String _phone = '';
  String? _email;
  bool _isLoading = false;
  bool _isSending = false;
  String? _devCode; // For development: show OTP code from server

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _phone = args['phone'] ?? '';
          _email = args['email'];
        });
        _sendOtp();
      }
    });
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (_phone.isEmpty) return;
    setState(() => _isSending = true);

    try {
      final result = await authService.sendOtp(
        phone: _phone,
        email: _email,
        purpose: 'register',
      );
      final data = result['data'] as Map<String, dynamic>?;
      if (data != null && data['devCode'] != null) {
        setState(() {
          _devCode = data['devCode'] as String;
        });
      }
    } on ApiException catch (e) {
      if (!mounted) return;
      _showSnackbar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackbar("Gagal mengirim OTP");
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _handleVerify() async {
    final code = _otpControllers.map((c) => c.text).join();
    if (code.length < 6) {
      _showSnackbar("Masukkan kode OTP 6 digit");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await authService.verifyOtp(
        phone: _phone,
        code: code,
        purpose: 'register',
      );

      if (!mounted) return;
      Navigator.pushNamed(context, '/profile_setup');
    } on ApiException catch (e) {
      if (!mounted) return;
      _showSnackbar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackbar("Gagal verifikasi OTP");
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
            Text(
              _phone.isNotEmpty ? _phone : "+62 xxx xxxx xxxx",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // Show dev code for testing
            if (_devCode != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Dev Code: $_devCode",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
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
              children: List.generate(6, (index) => _buildOtpBox(index)),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: _isSending ? null : _sendOtp,
              child: Text(
                _isSending ? "Mengirim..." : "Kirim Ulang Kode",
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                onPressed: _isLoading ? null : _handleVerify,
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
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

  Widget _buildOtpBox(int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
