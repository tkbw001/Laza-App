import 'package:firebase_auth/firebase_auth.dart';
import '../screens/user_data.dart';

class AuthService {
  // ================= LOGIN =================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // تسجيل دخول حقيقي باستخدام فايربيز
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // تحديث البيانات الثابتة في التطبيق
    UserData.email = email;
    UserData.username = email.split('@').first; 
  }

  // ================= SIGN UP =================
  Future<void> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    // إنشاء حساب حقيقي
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // تحديث البيانات
    UserData.email = email;
    UserData.username = username;
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    
    // تصفير البيانات عند الخروج
    UserData.username = "Guest User";
    UserData.email = "guest@laza.com";
  }
}