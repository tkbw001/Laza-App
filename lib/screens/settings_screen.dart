import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'privacy_screen.dart';
import 'language_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          "Settings",
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🌍 Language
            _settingsItem(
              context,
              icon: Icons.language,
              title: "Language",
              subtitle: "English",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LanguageScreen(),
                  ),
                );
              },
            ),

            // 🔔 Notifications
            _settingsItem(
              context,
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "On",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
            ),

            // 🔒 Privacy
            _settingsItem(
              context,
              icon: Icons.lock,
              title: "Privacy & Security",
              subtitle: "Standard",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacyScreen(),
                  ),
                );
              },
            ),

            // ℹ️ About
            _settingsItem(
              context,
              icon: Icons.info,
              title: "About App",
              subtitle: "Laza v1.0",
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Laza",
                  applicationVersion: "1.0.0",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===== Reusable Item =====
  Widget _settingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.onSurface.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: colors.primary.withOpacity(0.15),
              child: Icon(icon, color: colors.primary),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.6),
                      fontSize: 13,
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
