import 'package:flutter/material.dart';
import '../services/store_service.dart'; // 👈 استدعينا الخدمة
import 'main_layout.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  
  @override
  void initState() {
    super.initState();
    // 🔥 التعديل هنا: بننادي الدالة اللي بتحفظ الطلب في الأرشيف الأول وبعدين تفضي السلة
    StoreService.submitOrder(); 
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: colors.primary,
              ),
              const SizedBox(height: 20),
              Text(
                "Order Confirmed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Your order has been placed successfully.\nYou will receive an email confirmation shortly.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    // الرجوع للصفحة الرئيسية
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainLayout(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Go to Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}