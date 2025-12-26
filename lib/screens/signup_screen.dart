import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 1. مكتبة المصادقة
import 'package:cloud_firestore/cloud_firestore.dart'; // 👈 2. مكتبة قاعدة البيانات (الجديد)
import 'main_layout.dart';
import 'user_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // 👇👇👇 دالة التسجيل الحقيقية والمحدثة
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // أ. بنطلب من فايربيز يعمل يوزر جديد (Authentication)
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ب. بنخزن بيانات اليوزر في قاعدة البيانات (Firestore)
      // بنعمل ملف (Document) باسم الـ ID بتاع اليوزر عشان يبقى مميز
      await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'uId': credential.user!.uid, // بنحفظ الـ ID عشان نستخدمه بعدين
        'createdAt': FieldValue.serverTimestamp(), // تاريخ التسجيل
        'cart': [], // سلة فاضية
        'wishlist': [], // مفضلة فاضية
      });

      // ج. بنحفظ الاسم في الذاكرة المؤقتة (عشان يظهر علطول في التطبيق)
      UserData.username = usernameController.text.trim();
      UserData.email = emailController.text.trim();

      if (!mounted) return;

      // د. لو نجح، يدخل على التطبيق
      setState(() => _isLoading = false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainLayout()),
        (route) => false,
      );

    } on FirebaseAuthException catch (e) {
      // هـ. التعامل مع أخطاء فايربيز المعروفة
      setState(() => _isLoading = false);
      String errorMessage = "Authentication failed";
      
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }

      // إظهار رسالة الخطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      
    } catch (e) {
      // و. أي خطأ تاني (زي مشاكل النت)
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
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
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: colors.onSurface.withOpacity(0.1)),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: colors.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // ===== Username =====
              _label("Username", colors),
              TextFormField(
                controller: usernameController,
                style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.bold),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return "Username is required";
                  return null;
                },
                decoration: _inputDecoration(colors, hint: "Name"),
              ),

              const SizedBox(height: 20),

              // ===== Email =====
              _label("Email Address", colors),
              TextFormField(
                controller: emailController,
                style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.bold),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return "Email is required";
                  if (!value.contains("@")) return "Enter a valid email";
                  return null;
                },
                decoration: _inputDecoration(colors, hint: "Email"),
              ),

              const SizedBox(height: 20),

              // ===== Password =====
              _label("Password", colors),
              TextFormField(
                controller: passwordController,
                style: TextStyle(color: colors.onSurface, fontWeight: FontWeight.bold),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.length < 6) return "Password must be at least 6 characters";
                  return null;
                },
                decoration: _inputDecoration(
                  colors,
                  hint: "••••••••",
                  suffix: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ===== Sign Up Button =====
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isLoading ? null : _signUp, // استدعينا الدالة الجديدة
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Helpers =====
  Widget _label(String text, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          color: colors.onSurface.withOpacity(0.6),
          fontSize: 14,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(ColorScheme colors, {required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: colors.onSurface.withOpacity(0.3), 
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      filled: true,
      fillColor: colors.surface,
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.onSurface.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.onSurface.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.primary),
      ),
      errorStyle: const TextStyle(fontSize: 12),
    );
  }
}