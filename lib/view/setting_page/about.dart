// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use

import 'package:file_manager/view/setting_page/terms.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(height: 15),
                Text(
                  'Explorer App',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome to Explorer, your trusted file organizer. Explorer is the perfect tool to help you manage, secure, and find your files effortlessly.\nUser can add files easily and store in Explorer.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Key Features:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                        '📌 File Categorization:Organize your files into distinct categories such as images, videos, audios, and documents for easy access.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                    Text(
                        '📌 Secure Data: Your privacy is our priority. We use the powerful Hive database to ensure the security of your data.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                    Text(
                        '📌 Search Functionality: Quickly locate your files with our robust search feature.',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                    Text(
                        '📌 Chart system: Keep track of files added in this app and also view the total count of files in category based and overall files added .',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Terms and Conditions:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermsScreen(),
                    ));
                  },
                  child: Text(
                    'Read our Terms and Conditions',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
