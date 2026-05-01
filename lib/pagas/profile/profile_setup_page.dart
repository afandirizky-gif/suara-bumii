import 'package:flutter/material.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
        ),
        title: const Text("Lengkapi Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Bantu kami personalisasi pengalamanmu"),
            const SizedBox(height: 32),
    
            Stack(
              children: [
                CircleAvatar(
                  radius: 60, 
                  backgroundColor: Colors.grey.shade200, 
                  child: const Text("R", style: TextStyle(fontSize: 40, color: Colors.grey))
                ),
                Positioned(
                  bottom: 0, 
                  right: 0, 
                  child: CircleAvatar(
                    radius: 18, 
                    backgroundColor: const Color(0xFF4F6D52), 
                    child: const Icon(Icons.camera_alt_outlined, size: 18, color: Colors.white)
                  )
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Tap untuk ubah foto", style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 32),
            _buildDropdownField("Tanggal Lahir"),
            _buildDropdownField("Domisili"),
            _buildDropdownField("Jenis Kelamin"),
            _buildTextField("Kode referral (tidak wajib di isi)", "Dapat kode dari teman?"),
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4F1), 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDDE6DD))
              ),
              child: const Row(
                children: [
                  Icon(Icons.card_giftcard, color: Color(0xFF4F6D52)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Profil lengkap = +50 poin selamat datang 🎉", 
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1B3022))
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
           
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3022), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                onPressed: () {
                Navigator.pushReplacementNamed(context, '/onboarding_one');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profil berhasil disimpan! Silakan masuk."))
                  );
                },
                child: const Text(
                  "Simpan Profil", 
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDropdownField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true, 
                hint: const Text("Pilih"), 
                items: const [],
                onChanged: (val) {}
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint, 
              filled: true, 
              fillColor: const Color(0xFFF5F5F5), 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)
            )
          ),
        ],
      ),
    );
  }
}