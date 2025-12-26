import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_layout.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // عداد لمدة 3 ثواني
    Timer(const Duration(seconds: 3), () {
      // بعد الـ 3 ثواني، نسأل فايربيز: هل فيه يوزر مسجل حالياً؟
      if (FirebaseAuth.instance.currentUser != null) {
        // لو مسجل، روح على الهوم
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainLayout()),
        );
      } else {
        // لو مش مسجل، روح على اللوجن
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // بنجيب لون البراند الأساسي من الثيم
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: primaryColor, // الخلفية لونها موف
      body: Center(
        // اللوجو في النص
        child: Image.asset(
          'assets/Logo.png', // تأكد إن اسم الصورة صح عندك
          color: Colors.white, // بنخلي لون اللوجو أبيض
          width: 150, // حجم مناسب
          errorBuilder: (_, __, ___) => const Text(
            "Laza",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}