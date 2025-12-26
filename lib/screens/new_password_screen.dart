import 'package:flutter/material.dart';
import 'login_screen.dart'; // 👈 هنرجع للوجن في الآخر

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                "New Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Password Field
            Text(
              "Password",
              style: TextStyle(color: colors.onSurface.withOpacity(0.6)),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "New Password",
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),

            const SizedBox(height: 20),

            // Confirm Password Field
            Text(
              "Confirm Password",
              style: TextStyle(color: colors.onSurface.withOpacity(0.6)),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),

            const SizedBox(height: 50),
            Text(
              "Please write your new password.",
              style: TextStyle(color: colors.onSurface.withOpacity(0.4), fontSize: 13),
            ),
            const SizedBox(height: 20),

            // ===== زرار الحفظ =====
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // 👇 نرجع للوجن عشان السيناريو يخلص
                  // وبنمسح كل الصفحات القديمة عشان ميرجعش لورا
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password Reset Successfully! Login now.")),
                  );
                },
                child: const Text(
                  "Reset Password",
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