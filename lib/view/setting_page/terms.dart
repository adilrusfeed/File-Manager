// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Terms and conditions',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Divider(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  """
                  Welcome to the EXPLORER (file organizer)! By using this app, you agree to these simple terms:

          1. Use Responsibly: The Explorer App is designed to help you organize and arrange your personal files. Use it responsibly and keep your data accordingly!

          2. Your Content: The data you add is your responsibility.          

          3. App Ownership: The Explorer App and its content belong to us. Please don't modify, distribute, or reverse engineer the app without our permission.

          4. App Changes: We might update the app or these terms. Stay tuned for any announcements from us.

          5. App Availability: We aim to provide the app 24/7, but we can't guarantee it. We're not responsible for any inconvenience caused by app unavailability.

          6. Get in Touch: If you have questions, reach out to us at
                  """,
                ),
                Text(
                  'adilrusfeed@gmail.com',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('''
    By using the Explorer App, you agree to these terms.'''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
