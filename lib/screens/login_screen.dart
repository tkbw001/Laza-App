import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_layout.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // تسجيل الدخول بالإيميل والباسورد (الحقيقي)
  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayout()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Error"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 👇 الخدعة السينمائية: تسجيل دخول وهمي بالسوشيال ميديا
  Future<void> _mockSocialLogin(String provider) async {
    setState(() => _isLoading = true);
    
    // بنمثل إننا بنكلم السيرفر (انتظار 2 ثانية)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // ندخله على التطبيق علطول
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainLayout()),
    );
    
    // رسالة شيك
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logged in with $provider successfully! 🚀")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // اللوجو
                Image.asset(
                  'assets/Logo.png', 
                  height: 80, 
                  errorBuilder: (_,__,___) => Icon(Icons.shopping_bag, size: 80, color: colors.primary),
                ),
                const SizedBox(height: 20),
                Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colors.onSurface),
                ),
                Text(
                  "Please enter your data to continue",
                  style: TextStyle(color: colors.onSurface.withOpacity(0.5)),
                ),
                const SizedBox(height: 40),

                // حقول الإدخال
                _buildTextField("Email Address", _emailController, false, colors),
                const SizedBox(height: 15),
                _buildTextField("Password", _passwordController, true, colors),
                
                // نسيت الباسورد
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                    },
                    child: const Text("Forgot Password?", style: TextStyle(color: Colors.red)),
                  ),
                ),
                
                const SizedBox(height: 20),

                // زرار تسجيل الدخول
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),

                const SizedBox(height: 30),

                // ===== 👇 منطقة السوشيال ميديا (السيناريو الجديد) =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Or login with", style: TextStyle(color: colors.onSurface.withOpacity(0.6))),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton("Google", Colors.red, () => _mockSocialLogin("Google")),
                    const SizedBox(width: 20),
                    _socialButton("Facebook", Colors.blue, () => _mockSocialLogin("Facebook")),
                    const SizedBox(width: 20),
                    _socialButton("Twitter", Colors.black, () => _mockSocialLogin("Twitter")),
                  ],
                ),
                // ================================================

                const SizedBox(height: 40),

                // إنشاء حساب جديد
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("By connecting you agree to our ", style: TextStyle(fontSize: 11, color: colors.onSurface.withOpacity(0.5))),
                    const Text("Terms & Conditions", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: TextStyle(color: colors.onSurface.withOpacity(0.6))),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUpScreen()),
                        );
                      },
                      child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, color: colors.onSurface)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت صغيرة عشان منكررش كود حقول الإدخال
  Widget _buildTextField(String hint, TextEditingController controller, bool isPassword, ColorScheme colors) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  // ويدجت لزرار السوشيال ميديا
  Widget _socialButton(String type, Color color, VoidCallback onTap) {
    // بنحاول نعرض أيقونة، لو مفيش صورة
    IconData icon;
    if (type == "Google") icon = Icons.g_mobiledata; // أيقونة مؤقتة
    else if (type == "Facebook") icon = Icons.facebook;
    else icon = Icons.close; // علامة إكس لتويتر

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}