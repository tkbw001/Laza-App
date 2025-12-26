import 'dart:convert';
import 'package:http/http.dart' as http;
// 👇 تأكد إن المسار ده صح، لو الملف جوه فولدر models
import '../models/product_model.dart'; 

class ApiService {
  static const String _baseUrl = "https://api.escuelajs.co/api/v1/products";

  static Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // بناخد أول 20 منتج
        return data.take(20).map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}