import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
          "Wallet",
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
            // ===== Card Preview =====
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Visa",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.contactless,
                          color: Colors.white, size: 30),
                    ],
                  ),
                  Text(
                    "**** **** **** 5678",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ashley Richards",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "09/24",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ===== Recent Transactions =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem(
                    context,
                    "Nike Store",
                    "12 Oct, 2023",
                    "-\$120.00",
                    Icons.shopping_bag_outlined,
                  ),
                  _buildTransactionItem(
                    context,
                    "Adidas Mall",
                    "10 Oct, 2023",
                    "-\$85.00",
                    Icons.shopping_bag_outlined,
                  ),
                  _buildTransactionItem(
                    context,
                    "Wallet Top-up",
                    "05 Oct, 2023",
                    "+\$500.00",
                    Icons.account_balance_wallet_outlined,
                    isIncome: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Helpers =================

  Widget _buildTransactionItem(
    BuildContext context,
    String title,
    String date,
    String amount,
    IconData icon, {
    bool isIncome = false,
  }) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors.surface,
        child: Icon(icon, color: colors.onSurface),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.onSurface,
        ),
      ),
      subtitle: Text(
        date,
        style: TextStyle(
          color: colors.onSurface.withOpacity(0.6),
          fontSize: 12,
        ),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
