import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Back (شكليات)
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
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

              const SizedBox(height: 15),

              // Title
              Text(
                "Let's Get Started",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),

              const Spacer(),

              // Social buttons (ألوان البراند تفضل ثابتة)
              _buildSocialButton(
                color: const Color(0xFF4267B2),
                icon: Icons.facebook,
                text: "Facebook",
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildSocialButton(
                color: const Color(0xFF1DA1F2),
                icon: Icons.alternate_email,
                text: "Twitter",
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildSocialButton(
                color: const Color(0xFFEA4335),
                icon: Icons.g_mobiledata,
                text: "Google",
                onTap: () {},
              ),

              const Spacer(),

              // Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Signin",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Create Account
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  child: const Text(
                    "Create an Account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: onTap,
        icon: const Icon(Icons.circle, color: Colors.transparent), // يحافظ على محاذاة النص
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
