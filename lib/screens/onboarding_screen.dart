import 'package:flutter/material.dart';
import 'intro_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدمنا ألوان ثابتة هنا عشان التصميم يطلع زي الصورة بالظبط (أبيض وبنفسجي)
    // بغض النظر عن الـ Dark Mode حالياً عشان الخلفية ثابتة
    
    return Scaffold(
      body: Stack(
        children: [
          // 1️⃣ الصورة الخلفية (الراجل)
          Positioned.fill(
            child: Image.asset(
              'assets/images/man.png',
              fit: BoxFit.cover, // تملا الشاشة كلها
              alignment: Alignment.topCenter, // نركز على الجزء اللي فوق من الصورة
            ),
          ),

          // 2️⃣ الكارت الأبيض (اللي فيه الكلام والزراير)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(15), // مسافة من الحواف (زي التصميم)
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white, // الكارت لونه أبيض
                borderRadius: BorderRadius.circular(30), // حواف مدورة
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // الكارت ياخد مساحة الكلام بس
                children: [
                  // العنوان
                  const Text(
                    "Look Good, Feel Good",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // النص أسود عشان الخلفية بيضاء
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // الوصف
                  const Text(
                    "Create your individual & unique style and look amazing everyday.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey, // لون رمادي فاتح
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 3️⃣ أزرار الاختيار (Men / Women)
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FA), // رمادي فاتح جداً للخلفية
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        // زرار Men (رمادي)
                        Expanded(
                          child: InkWell(
                            onTap: () => _goNext(context),
                            borderRadius: BorderRadius.circular(15),
                            child: const Center(
                              child: Text(
                                "Men",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // زرار Women (بنفسجي)
                        Expanded(
                          child: InkWell(
                            onTap: () => _goNext(context),
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9775FA), // البنفسجي بتاعنا
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "Women",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 4️⃣ زرار Skip
                  TextButton(
                    onPressed: () => _goNext(context),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey, // رمادي عشان يبان إنه ثانوي
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة الانتقال
  void _goNext(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const IntroScreen()),
    );
  }
}