// ignore_for_file: deprecated_member_use

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
                const SizedBox(
                  height: 30,
                ),
                Text(
                  """
                  welcome to the EXPLORER(file organizer)! By using this app, you agree to these simple terms:

                  1. Use Responsibly: The Explorer App is designed to help you organize and arrange your personal files. Use it responsibly and keep your data accordingly!

                  2. Your Content: The data you add is your responsibility.

                  3. Respect Privacy: We care about your privacy. Your use of the app is subject to our Privacy Policy.

                  4. App Ownership: The Explorer App and its content belong to us. Please don't modify, distribute, or reverse engineer the app without our permission.

                  5. App Changes: We might update the app or these terms. Stay tuned for any announcements from us.

                  6. App Availability: We aim to provide the app 24/7, but we can't guarantee it. We're not responsible for any inconvenience caused by app unavailability.

                  7. Get in Touch: If you have questions, reach out to us at
                  """,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'adilrusfeed@gmail.com',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const Text('''
                  By using the Explorer App, you agree to these terms. Keep your personal data "safe"! '''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
