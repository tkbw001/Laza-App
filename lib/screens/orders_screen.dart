import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
          "My Orders",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _OrderItem(
            orderId: "#LZ1234",
            status: "Delivered",
            price: "\$120",
          ),
          _OrderItem(
            orderId: "#LZ1235",
            status: "Processing",
            price: "\$99",
          ),
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String orderId;
  final String status;
  final String price;

  const _OrderItem({
    required this.orderId,
    required this.status,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: colors.onSurface.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                status,
                style: TextStyle(
                  color: status == "Delivered"
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            ],
          ),
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
