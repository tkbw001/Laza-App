import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreService {
  static String? get uId => FirebaseAuth.instance.currentUser?.uid;

  // ================= 🛒 CART (COLLECTION) =================

  // إضافة منتج للسلة (كمستند منفصل)
  static Future<void> addToCart(Map<String, dynamic> product) async {
    if (uId == null) return;
    // بنستخدم ID المنتج كاسم للمستند عشان منكرروش
    String productId = product['id'].toString(); 
    
    await FirebaseFirestore.instance
        .collection('carts')
        .doc(uId)
        .collection('items')
        .doc(productId)
        .set(product);
  }

  // حذف منتج من السلة
  static Future<void> removeFromCart(Map<String, dynamic> product) async {
    if (uId == null) return;
    String productId = product['id'].toString();

    await FirebaseFirestore.instance
        .collection('carts')
        .doc(uId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  // ================= ❤️ WISHLIST (COLLECTION) =================

  static Future<void> addToWishlist(Map<String, dynamic> product) async {
    if (uId == null) return;
    String productId = product['id'].toString();

    await FirebaseFirestore.instance
        .collection('favorites') // حسب طلب المشروع favorites مش wishlist
        .doc(uId)
        .collection('items')
        .doc(productId)
        .set(product);
  }

  static Future<void> removeFromWishlist(Map<String, dynamic> product) async {
    if (uId == null) return;
    String productId = product['id'].toString();

    await FirebaseFirestore.instance
        .collection('favorites')
        .doc(uId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  // ================= 📦 ORDERS & CLEAR =================

  static Future<void> submitOrder() async {
    if (uId == null) return;

    // 1. نجيب كل المنتجات اللي في الكولكشن
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection('carts')
        .doc(uId)
        .collection('items')
        .get();

    List<Map<String, dynamic>> cartItems = cartSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    if (cartItems.isEmpty) return;

    // 2. نحسب الإجمالي
    double totalPrice = 0;
    for (var item in cartItems) {
       double price = double.tryParse(item['price'].toString().replaceAll('\$', '')) ?? 0.0;
       int quantity = item['quantity'] ?? 1;
       totalPrice += price * quantity;
    }

    // 3. نبعت الطلب للأرشيف
    await FirebaseFirestore.instance.collection('orders').add({
      'uId': uId,
      'items': cartItems,
      'totalPrice': totalPrice,
      'status': 'Pending',
      'dateTime': FieldValue.serverTimestamp(),
    });

    // 4. نمسح السلة
    await clearCart();
  }

  // دالة مسح السلة (لازم نمسح المستندات واحد واحد في Firestore)
  static Future<void> clearCart() async {
    if (uId == null) return;

    var collection = FirebaseFirestore.instance
        .collection('carts')
        .doc(uId)
        .collection('items');
        
    var snapshots = await collection.get();
    
    // Batch write عشان نمسح كله مرة واحدة وسريع
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}