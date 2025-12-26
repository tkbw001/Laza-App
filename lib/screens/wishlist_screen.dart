import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/store_service.dart';
import 'main_layout.dart';
import 'details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final String? uId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // 👇 التعديل: الاستماع للـ Collection الجديد
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('favorites')
          .doc(uId)
          .collection('items')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Scaffold(body: Center(child: Text("Error")));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(backgroundColor: colors.surface, body: const Center(child: CircularProgressIndicator()));
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          // ... (نفس تصميم الشاشة الفاضية)
          return Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(backgroundColor: colors.surface, elevation: 0, title: const Text("Wishlist"), centerTitle: true),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 100, color: colors.onSurface.withOpacity(0.3)),
                  const SizedBox(height: 20),
                  Text("Your wishlist is empty", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.onSurface)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, 
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainLayout()), (route) => false),
                      child: const Text("Explore Products", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: colors.surface,
          appBar: AppBar(backgroundColor: colors.surface, elevation: 0, title: const Text("Wishlist"), centerTitle: true),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final item = docs[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(
                        name: item['name'],
                        price: "\$${item['price']}",
                        image: item['image'],
                        description: item['description'] ?? "No description",
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: colors.onSurface.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(item['image'], width: 70, height: 70, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.error)),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 5),
                            Text("\$${item['price']}", style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () => StoreService.removeFromWishlist(item),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}