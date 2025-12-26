import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String selectedMethod = "MasterCard";

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
          "Add New Card",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Payment Methods =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPayBox(context, "MasterCard", Icons.credit_card),
                _buildPayBox(context, "PayPal", Icons.account_balance_wallet),
                _buildPayBox(context, "Bank", Icons.account_balance),
              ],
            ),

            const SizedBox(height: 30),

            _buildField(context, "Card Owner", "Mrh Raju"),
            const SizedBox(height: 20),

            _buildField(context, "Card Number", "5254 7634 8734 7690"),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: _buildField(context, "EXP", "24/24")),
                const SizedBox(width: 15),
                Expanded(child: _buildField(context, "CVV", "7763")),
              ],
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      // ===== Add Card Button =====
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Add Card",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // ================= Helpers =================

  Widget _buildField(BuildContext context, String label, String hint) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
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
        ),
      ],
    );
  }

  Widget _buildPayBox(BuildContext context, String title, IconData icon) {
    final colors = Theme.of(context).colorScheme;
    final bool isSelected = selectedMethod == title;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          setState(() {
            selectedMethod = title;
          });
        },
        child: Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            color: isSelected ? colors.primary : colors.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected
                  ? colors.primary
                  : colors.onSurface.withOpacity(0.2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : colors.onSurface.withOpacity(0.6),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Colors.white
                      : colors.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
