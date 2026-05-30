import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class InfoScreen extends StatelessWidget {
  final String title;

  const InfoScreen({super.key, required this.title});

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
          children: [
            Text(
              'Last Updated: May 2026',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppTheme.textLight,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _getDummyTextForTitle(title),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.textDark,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDummyTextForTitle(String title) {
    if (title == 'Terms of Service') {
      return '1. Acceptance of Terms\n'
          'By accessing and using FR Style\'s, you accept and agree to be bound by the terms and provision of this agreement.\n\n'
          '2. Use License\n'
          'Permission is granted to temporarily download one copy of the materials (information or software) on FR Style\'s app for personal, non-commercial transitory viewing only.\n\n'
          '3. Disclaimer\n'
          'The materials on FR Style\'s app are provided on an \'as is\' basis. FR Style\'s makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.\n\n'
          '4. Limitations\n'
          'In no event shall FR Style\'s or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on FR Style\'s app.';
    } else if (title == 'Privacy Policy') {
      return '1. Information Collection\n'
          'We collect information from you when you register on our app, place an order, subscribe to our newsletter or fill out a form.\n\n'
          '2. Use of Information\n'
          'Any of the information we collect from you may be used in one of the following ways:\n'
          '• To personalize your experience\n'
          '• To improve our app\n'
          '• To improve customer service\n'
          '• To process transactions\n\n'
          '3. Data Protection\n'
          'We implement a variety of security measures to maintain the safety of your personal information when you place an order or enter, submit, or access your personal information.\n\n'
          '4. Cookies\n'
          'We use cookies to understand and save your preferences for future visits and compile aggregate data about app traffic and app interaction.';
    } else if (title == 'License Information') {
      return 'FR Style\'s App uses various open-source packages and resources.\n\n'
          'Flutter Framework\n'
          'Copyright 2014 The Flutter Authors. All rights reserved.\n\n'
          'Google Fonts\n'
          'Licensed under the SIL Open Font License, Version 1.1.\n\n'
          'Firebase\n'
          'Copyright 2026 Google LLC. All rights reserved.\n\n'
          'This application and its original content, features, and functionality are owned by FR Style\'s and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.';
    } else if (title == 'Return Policy') {
      return '1. 30-Day Return Policy\n'
          'We offer a full 30-day return policy for all unworn, unwashed, and undamaged items with original tags still attached. Returns within this period are eligible for a full refund or exchange.\n\n'
          '2. Easy Return Steps\n'
          '• Pack your items securely in the original packaging.\n'
          '• Print the prepaid return label from your order history details.\n'
          '• Drop off the package at any authorized shipping location.\n\n'
          '3. Refund Processing\n'
          'Once we receive and inspect your returned package, your refund will be processed and applied to your original payment method within 5 to 7 business days.';
    }
    return 'Detailed information for $title will be available here.';
  }
}
