import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // بنجيب اليوزر الحالي من فايربيز
  final User? user = FirebaseAuth.instance.currentUser;

  // دالة الخروج
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // لو اليوزر مش موجود أو داخل كـ Guest (Anonymous)
    bool isGuest = user == null || user!.isAnonymous;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const BackButton(), // زرار رجوع
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // كارت المعلومات (ديناميكي)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // الصورة
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: isGuest 
                        ? null // لو جيست مفيش صورة
                        : const NetworkImage("https://i.pravatar.cc/300"), // صورة عشوائية لليوزر
                    child: isGuest ? const Icon(Icons.person, size: 30) : null,
                  ),
                  const SizedBox(width: 15),
                  
                  // الاسم والإيميل (هنا الذكاء كله) 🧠
                  Expanded(
                    child: isGuest
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Guest User",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface),
                              ),
                              Text(
                                "guest@laza.com",
                                style: TextStyle(fontSize: 14, color: colors.onSurface.withOpacity(0.5)),
                              ),
                            ],
                          )
                        : FutureBuilder<DocumentSnapshot>(
                            // لو يوزر حقيقي، روح هات بياناته من Firestore
                            future: FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Text("Loading...");
                              }
                              
                              // البيانات اللي راجعة
                              String name = "User";
                              String email = user!.email ?? "No Email";

                              if (snapshot.hasData && snapshot.data!.exists) {
                                final data = snapshot.data!.data() as Map<String, dynamic>;
                                // بنحاول نجيب الاسم، لو مش موجود بنحط User
                                name = data['username'] ?? data['name'] ?? "User";
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name, // الاسم الحقيقي
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface),
                                  ),
                                  Text(
                                    email, // الإيميل الحقيقي
                                    style: TextStyle(fontSize: 14, color: colors.onSurface.withOpacity(0.5)),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // زرار تسجيل الخروج
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: _logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}