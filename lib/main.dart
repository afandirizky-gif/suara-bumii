import 'package:flutter/material.dart';
// Import semua halaman dari folder pagas
import 'pagas/splash_screen.dart';
import 'pagas/login_page.dart';        // <--- Pastikan ini sudah di-import
import 'pagas/auth/register_page.dart';
import 'pagas/auth/otp_page.dart';
import 'pagas/profile_setup_page.dart';
import 'pagas/onboarding/onboarding_one.dart';
import 'pagas/onboarding/onboarding_two.dart';
import 'pagas/onboarding/onboarding_three.dart';
import 'pagas/home_page.dart';
import 'pagas/scan_sampah_page.dart';
import 'pagas/profile_page.dart';
import 'pagas/reward_referral_page.dart';
import 'pagas/reward_riwayat_page.dart';
import 'pagas/reward_tukar_page.dart';
import 'pagas/challenge_aktif_page.dart';
import 'pagas/challenge_tersedia_page.dart';
import 'pagas/challenge_selesai_page.dart';
import 'pagas/setor_utama_page.dart';
import 'pagas/setor_jemput_page.dart'; 
import 'pagas/setor_drop_point_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suara Bumi',
      theme: ThemeData(
        // Menggunakan colorScheme agar lebih modern di Flutter terbaru
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F6D52),
          primary: const Color(0xFF1B3022),
        ),
        useMaterial3: true, // Biar tampilan tombol & input lebih kekinian
        fontFamily: 'Inter', 
      ),
      
      // Halaman awal tetap Splash Screen
      home: const SplashScreen(),

      // Peta jalan (Navigasi) aplikasi kamu
      routes: {
        '/login': (context) => const LoginPage(),         // Alamat Login
        '/register': (context) => const RegisterPage(),   // Alamat Daftar
        '/otp': (context) => const OtpPage(),             // Alamat Verifikasi OTP
        '/profile_setup': (context) => const ProfileSetupPage(), // Alamat Lengkapi Profil
        '/onboarding_one': (context) => const OnboardingOne(),
        '/onboarding_two': (context) => const OnboardingTwo(),
        '/onboarding_three': (context) => const OnboardingThree(),
        '/home': (context) => const HomePage(),
        '/scan_sampah': (context) => const ScanSampahPage(),
        '/profile': (context) => const ProfilePage(),
        '/reward_tukar': (context) => const RewardTukarPage(),
        '/reward_riwayat': (context) => const RewardRiwayatPage(),
        '/reward_referral': (context) => const RewardReferralPage(),
        '/challenge_aktif': (context) => const ChallengeAktifPage(),
        '/challenge_tersedia': (context) => const ChallengeTersediaPage(),
        '/challenge_selesai': (context) => const ChallengeSelesaiPage(),
        '/setor_utama': (context) => const SetorUtamaPage(),
        '/setor_jemput': (context) => const SetorJemputPage(),
         '/setor_drop_point': (context) => const SetorDropPointPage(),
      },
    );
  }
}