import 'package:flutter/material.dart';
import 'package:suara_bumi/pagas/auth/register_page.dart';
import 'pagas/splash_screen.dart';
import 'pagas/login_page.dart';
import 'pagas/auth/otp_page.dart';
import 'pagas/profile/profile_setup_page.dart';
import 'pagas/onboarding/onboarding_one.dart';
import 'pagas/onboarding/onboarding_two.dart';
import 'pagas/onboarding/onboarding_three.dart';
import 'pagas/home_page.dart';
import 'pagas/scan_sampah_page.dart';
import 'pagas/profile/profile_page.dart';
import 'pagas/reward/reward_referral_page.dart';
import 'pagas/reward/reward_riwayat_page.dart';
import 'pagas/reward/reward_tukar_page.dart';
import 'pagas/challenge/challenge_aktif_page.dart';
import 'pagas/challenge/challenge_tersedia_page.dart';
import 'pagas/challenge/challenge_selesai_page.dart';
import 'pagas/setor/setor_utama_page.dart';
import 'pagas/setor/setor_jemput_page.dart';
import 'pagas/setor/setor_drop_point_page.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F6D52),
          primary: const Color(0xFF1B3022),
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/otp': (context) => const OtpPage(),
        '/profile_setup': (context) => const ProfileSetupPage(),
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
