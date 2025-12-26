import 'package:flutter/material.dart';
import 'order_confirmed_screen.dart';
import 'add_card_screen.dart';
// شيلنا import user_model و user_data لأننا مش محتاجينهم هنا

class PaymentScreen extends StatelessWidget {
  // 👇 التعديل: شيلنا المتغيرات عشان الصفحة تبقى const وخفيفة
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Cards =====
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCreditCard(
                    color: const Color(0xFFF5675E),
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 15),
                  _buildCreditCard(
                    color: colors.surface,
                    textColor: colors.onSurface,
                    hasBorder: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ===== Add New Card =====
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddCardScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add_box_outlined, color: colors.primary),
              label: Text(
                "Add New Card",
                style: TextStyle(color: colors.primary),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: colors.primary),
                backgroundColor: colors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 30),

            _buildLabel(context, "Card Owner"),
            _buildTextField(context, "Mr. Ashley Richards"),
            const SizedBox(height: 15),

            _buildLabel(context, "Card Number"),
            _buildTextField(context, "5254 7634 8734 5678"),
            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(context, "EXP"),
                      _buildTextField(context, "24/24"),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(context, "CVV"),
                      _buildTextField(context, "7763"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // ===== Bottom Button =====
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        color: colors.surface,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              // 👇 التعديل المهم: بننادي الصفحة اللي بعدها من غير أي تعقيدات
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderConfirmedScreen(),
                ),
              );
            },
            child: const Text(
              "Save Card",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // ================== Widgets ==================

  Widget _buildCreditCard({
    required Color color,
    required Color textColor,
    bool hasBorder = false,
  }) {
    return Container(
      width: 300,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border:
            hasBorder ? Border.all(color: Colors.grey.withOpacity(0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Visa",
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.contactless, color: textColor),
            ],
          ),
          Text(
            "Mr. Ashley Richards",
            style: TextStyle(color: textColor),
          ),
          Text(
            "5254 **** **** 5678",
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colors.onSurface,
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hint) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: colors.onSurface.withOpacity(0.5),
        ),
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}