import 'package:flutter/material.dart';
import '../services/store_service.dart';
import 'reviews_screen.dart';
import 'cart_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final String description; // 👈 1. ضفنا الوصف هنا

  const DetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description, // 👈 ومطلوب هنا
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // الصورة
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الاسم والسعر
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.onSurface),
                            ),
                          ),
                          Text(
                            widget.price,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.onSurface),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // المراجعات (ثابتة)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface)),
                          TextButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewsScreen())),
                            child: Text("View All", style: TextStyle(color: colors.onSurface.withOpacity(0.6), fontSize: 13)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // الوصف (دلوقتي بقى حقيقي!)
                      Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.onSurface)),
                      const SizedBox(height: 10),
                      Text(
                        widget.description, // 👈 2. عرضنا الوصف الحقيقي هنا
                        style: TextStyle(color: colors.onSurface.withOpacity(0.6), height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // زرار الرجوع
          Positioned(
            top: 50, left: 20,
            child: CircleAvatar(
              backgroundColor: colors.surface,
              child: IconButton(icon: Icon(Icons.arrow_back, color: colors.onSurface), onPressed: () => Navigator.pop(context)),
            ),
          ),
        ],
      ),

      // زرار الإضافة للسلة
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        color: colors.surface,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              StoreService.addToCart({
                'name': widget.name,
                'price': widget.price.replaceAll('\$', ''),
                'image': widget.image,
                'quantity': 1,
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to Cart 🛒"), duration: Duration(seconds: 1)));
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
            },
            child: const Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }
}