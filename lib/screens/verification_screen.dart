import 'package:flutter/material.dart';
import 'new_password_screen.dart'; // 👈 هنروح لدي بعدها

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Verification Code",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/Logo.png', // حط صورة قفل أو اللوجو هنا لو تحب
              height: 100,
              errorBuilder: (_,__,___) => const Icon(Icons.lock_clock, size: 80),
            ),
            const SizedBox(height: 30),
            Text(
              "We sent a code to your email.\nPlease enter it below.",
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurface.withOpacity(0.5)),
            ),
            const SizedBox(height: 40),

            // ===== خانات الكود (شكل جمالي) =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: colors.onSurface.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colors.onSurface),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: "", // نخفي عداد الحروف
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            Text(
              "00:45",
              style: TextStyle(fontWeight: FontWeight.bold, color: colors.onSurface),
            ),
            const SizedBox(height: 50),

            // ===== زرار التأكيد =====
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // 👇 هنا السيناريو بيكمل لصفحة الباسورد الجديد
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
                  );
                },
                child: const Text(
                  "Confirm Code",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}