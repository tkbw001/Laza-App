import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/api_service.dart';
import '../services/store_service.dart';
import '../models/product_model.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> _allProducts = [];
  List<ProductModel> _foundProducts = [];
  bool _isLoading = true;

  final String? uId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService.getProducts();
      setState(() {
        _allProducts = products;
        _foundProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error loading products: $e");
    }
  }

  void _runFilter(String keyword) {
    List<ProductModel> results = [];
    if (keyword.isEmpty) {
      results = _allProducts;
    } else {
      results = _allProducts
          .where((product) =>
              product.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Column(
            children: [
              _header(colors),
              const SizedBox(height: 16),
              // Search Field
              TextField(
                onChanged: (value) => _runFilter(value),
                style: TextStyle(color: colors.onSurface),
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: colors.onSurface.withOpacity(0.5)),
                  prefixIcon: Icon(Icons.search, color: colors.onSurface),
                  filled: true,
                  fillColor: colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colors.onSurface.withOpacity(0.1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colors.onSurface.withOpacity(0.1)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Products Grid
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    // 👇 التعديل: بنسمع للـ Collection الجديدة بتاعت المفضلة
                    : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('favorites')
                            .doc(uId)
                            .collection('items')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) return const Text("Something went wrong");

                          // بنجمع أسماء المنتجات اللي في المفضلة عشان نعرف نلون القلب
                          List<String> favNames = [];
                          if (snapshot.hasData) {
                            favNames = snapshot.data!.docs
                                .map((doc) => doc['name'].toString())
                                .toList();
                          }

                          return _foundProducts.isEmpty
                              ? Center(child: Text("No products found", style: TextStyle(color: colors.onSurface)))
                              : _productsGrid(colors, favNames);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(ColorScheme colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Laza",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: colors.onSurface),
        ),
        Icon(Icons.shopping_bag_outlined, size: 28, color: colors.onSurface),
      ],
    );
  }

  Widget _productsGrid(ColorScheme colors, List<String> favNames) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _foundProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        final product = _foundProducts[index];
        
        final productMap = {
          "name": product.title,
          "price": product.price.toString(),
          "image": product.image,
          "description": product.description,
          "id": product.id,
        };

        // 👇 فحص هل المنتج موجود في القائمة الجديدة ولا لأ
        final isFav = favNames.contains(product.title);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                            name: product.title,
                            price: "\$${product.price}",
                            image: product.image,
                            description: product.description,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colors.surface,
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                          onError: (_, __) => const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: colors.surface,
                      radius: 18,
                      child: IconButton(
                        iconSize: 18,
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          if (isFav) {
                            StoreService.removeFromWishlist(productMap);
                          } else {
                            StoreService.addToWishlist(productMap);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: colors.onSurface),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600, fontSize: 14),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: colors.primary),
                  onPressed: () {
                    StoreService.addToCart({
                      ...productMap,
                      'quantity': 1,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added to Cart 🛒"), duration: const Duration(seconds: 1)),
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}