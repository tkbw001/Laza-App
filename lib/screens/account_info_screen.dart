import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  String username = "Mrh Raju";
  String email = "mrh@example.com";
  String phone = "+20 123 456 789";

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
          "Account Information",
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
          children: [
            _infoTile(
              icon: Icons.person_outline,
              label: "Username",
              value: username,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      title: "Username",
                      initialValue: username,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() => username = result);
                }
              },
            ),

            _infoTile(
              icon: Icons.email_outlined,
              label: "Email",
              value: email,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      title: "Email",
                      initialValue: email,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() => email = result);
                }
              },
            ),

            _infoTile(
              icon: Icons.phone_outlined,
              label: "Phone",
              value: phone,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      title: "Phone",
                      initialValue: phone,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() => phone = result);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===== Widget =====
  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.onSurface.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colors.onSurface.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
