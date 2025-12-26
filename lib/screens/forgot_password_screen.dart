import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verification_screen.dart'; // 👈 تأكد إن الملف ده موجود

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  // 👇 الدالة المعدلة (النسخة الصح)
  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. إرسال الإيميل الحقيقي (عشان الوظيفة تشتغل في الخلفية)
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      setState(() => _isLoading = false);

      // 2. الانتقال لصفحة الكود (Verification) عشان السيناريو يكمل قدام الكاميرا
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const VerificationScreen()),
      );

    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Error"), backgroundColor: Colors.red),
      );
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Image.asset(
              'assets/Logo.png', 
              height: 80, 
              errorBuilder: (_,__,___)=> const Icon(Icons.lock, size: 80)
            ),
            const SizedBox(height: 40),
            Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colors.onSurface),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter your email address and we will send you a link to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurface.withOpacity(0.5)),
            ),
            const SizedBox(height: 50),
            
            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email Address",
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            
            const Spacer(),
            
            Text(
              "Please write your email to receive a\nconfirmation code to set a new password.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: colors.onSurface.withOpacity(0.4)),
            ),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isLoading ? null : _resetPassword,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Confirm Mail", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}