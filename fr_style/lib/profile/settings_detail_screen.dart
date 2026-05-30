import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class SettingsDetailScreen extends StatelessWidget {
  final String title;
  const SettingsDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildContent(title),
        ),
      ),
    );
  }

  List<Widget> _buildContent(String title) {
    switch (title) {
      case 'Notifications':
        return [
          _buildSwitchTile('Push Notifications', true),
          _buildSwitchTile('Email Notifications', false),
          _buildSwitchTile('Order Updates', true),
          _buildSwitchTile('Promotional Offers', false),
          _buildSwitchTile('Newsletter', true),
        ];
      case 'Change Password':
        return [
          const Text('Enter your current and new password below.'),
          const SizedBox(height: 24),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              prefixIcon: Icon(Icons.lock_reset_outlined),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
              prefixIcon: Icon(Icons.lock_reset_outlined),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryDark,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('UPDATE PASSWORD', style: TextStyle(color: Colors.white)),
          ),
        ];
      case 'Help Center':
        return [
          Text('Frequently Asked Questions', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildFaqItem('How do I track my order?', 'You can track your order in the "Active Orders" section of your profile.'),
          _buildFaqItem('What is your return policy?', 'We offer a 30-day return policy for most items. See full terms for details.'),
          _buildFaqItem('How can I contact support?', 'You can email us at support@frstyles.com or call us at 1-800-STYLE.'),
          const SizedBox(height: 32),
          Center(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('CHAT WITH US'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
          ),
        ];
      case 'About FR Style\'s':
        return [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "FR Style's",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryDark,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Version 1.0.0', style: GoogleFonts.poppins(color: AppTheme.textLight)),
                const SizedBox(height: 40),
              ],
            ),
          ),
          const Text(
            'FR Style\'s is a premier fashion destination dedicated to providing the latest trends with a focus on quality and minimalist elegance.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildInfoLink('Terms of Service'),
          _buildInfoLink('Privacy Policy'),
          _buildInfoLink('License Information'),
        ];
      default:
        return [const Text('Content coming soon...')];
    }
  }

  Widget _buildSwitchTile(String title, bool value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14)),
      trailing: Switch(
        value: value,
        onChanged: (_) {},
        activeThumbColor: AppTheme.primaryDark,
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(question, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(answer, style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textLight)),
        ),
      ],
    );
  }

  Widget _buildInfoLink(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: () {},
    );
  }
}
