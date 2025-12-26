import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/store_service.dart';
import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final String? uId = FirebaseAuth.instance.currentUser?.uid;

  double _calculateTotal(List<QueryDocumentSnapshot> docs) {
    double total = 0;
    for (var doc in docs) {
      final item = doc.data() as Map<String, dynamic>;
      double price = double.tryParse(item['price'].toString().replaceAll('\$', '')) ?? 0.0;
      int quantity = item['quantity'] ?? 1;
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // 👇 التعديل: الاستماع للـ Collection الجديد
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('carts')
          .doc(uId)
          .collection('items')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Scaffold(body: Center(child: Text("Error loading cart")));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(backgroundColor: colors.surface, body: const Center(child: CircularProgressIndicator()));
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          // ... (نفس تصميم الشاشة الفاضية اللي فات بالظبط)
          return Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(backgroundColor: colors.surface, elevation: 0, title: const Text("Cart"), centerTitle: true),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 120, color: colors.onSurface.withOpacity(0.3)),
                  const SizedBox(height: 20),
                  Text("Your cart is empty", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.onSurface)),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: colors.surface,
          appBar: AppBar(title: const Text("Cart"), centerTitle: true),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final item = docs[index].data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: colors.onSurface.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item['image'], width: 70, height: 70, fit: BoxFit.cover,
                        errorBuilder: (_,__,___) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text("\$${item['price']}", style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        StoreService.removeFromCart(item);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.onSurface.withOpacity(0.1))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Text("\$${_calculateTotal(docs).toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.primary)),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: colors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen())),
                    child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}