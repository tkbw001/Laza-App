class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  // دالة بتحول الـ JSON اللي جاي من النت لـ بيانات نقدر نستخدمها
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? "No Title",
      price: (json['price'] as num).toDouble(), // تأمين عشان لو الرقم جاي int
      description: json['description'] ?? "No Description",
      // الـ API ده أحياناً بيبعت الصور جوه قائمة، فبناخد أول صورة
      image: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? json['images'][0].toString().replaceAll('["', '').replaceAll('"]', '') // تنظيف الرابط لو فيه أقواس زيادة
          : "https://via.placeholder.com/150",
    );
  }
}