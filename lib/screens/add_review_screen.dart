import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double _ratingValue = 4.0;

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
          "Add Review",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Name =====
            _label(context, "Name"),
            _textField(context, "Type your name"),

            const SizedBox(height: 20),

            // ===== Experience =====
            _label(context, "How was your experience?"),
            _textField(
              context,
              "Describe your experience",
              maxLines: 5,
            ),

            const SizedBox(height: 20),

            // ===== Rating =====
            _label(context, "Star Rating"),
            Row(
              children: [
                Text(
                  _ratingValue.toStringAsFixed(1),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _ratingValue,
                    min: 1,
                    max: 5,
                    divisions: 8,
                    activeColor: colors.primary,
                    inactiveColor: colors.onSurface.withOpacity(0.2),
                    onChanged: (value) {
                      setState(() => _ratingValue = value);
                    },
                  ),
                ),
                Text(
                  "5.0",
                  style: TextStyle(
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // ===== Submit Button =====
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
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Submit Review",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // ================= Helpers =================

  Widget _label(BuildContext context, String text) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colors.onSurface,
        ),
      ),
    );
  }

  Widget _textField(
    BuildContext context,
    String hint, {
    int maxLines = 1,
  }) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      maxLines: maxLines,
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
