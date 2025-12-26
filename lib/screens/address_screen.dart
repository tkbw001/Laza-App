import 'package:flutter/material.dart';
import 'payment_screen.dart';
// شيلنا import user_data لأننا مش محتاجين نمرره

class AddressScreen extends StatelessWidget {
  // 👇 التعديل: شيلنا المتغير user عشان الصفحة تبقى خفيفة
  const AddressScreen({super.key});

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
          "Address",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(context, "Name"),
            _buildTextField(context, "Type your name"),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(context, "Country"),
                      _buildTextField(context, "Egypt"),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel(context, "City"),
                      _buildTextField(context, "Cairo"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildLabel(context, "Phone Number"),
            _buildTextField(context, "+20 123 456 789"),
            const SizedBox(height: 20),

            _buildLabel(context, "Address"),
            _buildTextField(context, "Street name, Building No."),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Save as primary address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: colors.primary,
                ),
              ],
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

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
              // 👇 التعديل: بنروح لصفحة الدفع من غير ما نبعت أي بيانات معقدة
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentScreen(),
                ),
              );
            },
            child: const Text(
              "Save Address",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // ================= Helpers =================

  Widget _buildLabel(BuildContext context, String label) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
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