import 'package:flutter/material.dart';
import 'product_card.dart'; 

class BrandItemsScreen extends StatelessWidget {
  const BrandItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // البار العلوي مختلف هنا: فيه لوجو نايكي
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
             margin: const EdgeInsets.all(8),
             decoration: BoxDecoration(color: colorScheme.surface, shape: BoxShape.circle),
             child: IconButton(icon: Icon(Icons.arrow_back, color: colorScheme.onSurface), onPressed: () => Navigator.pop(context)),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(color: colorScheme.surface, borderRadius: BorderRadius.circular(20)),
          child: Icon(Icons.check, color: colorScheme.onSurface), // استبدل دي بصورة اللوجو لو معاك (Image.asset)
        ),
        centerTitle: true,
        actions: [
           Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shopping_bag_outlined, color: colorScheme.onSurface),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // الهيدر: عدد العناصر وزرار Sort
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("365 Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                    const SizedBox(height: 5),
                    const Text("Available in stock", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.sort, size: 16, color: colorScheme.onSurface),
                  label: Text("Sort", style: TextStyle(color: colorScheme.onSurface)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.surface,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // نفس الشبكة بالظبط TKBW
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return const ProductCard(
                    name: "Nike Air Max 270 React ENG",
                    price: "\$120",
                    image: "https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=300",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}