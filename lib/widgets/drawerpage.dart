// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:file_manager/setting_page/about.dart';
import 'package:file_manager/setting_page/exit.dart';
import 'package:file_manager/setting_page/reset.dart';
import 'package:file_manager/setting_page/terms.dart';
import 'package:file_manager/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DrawerHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Lottie.asset(
              'assets/images/setting ltiie.json',
              width: 250,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AboutScreen(),
              ));
            },
            child: DrawerItem(text: "about", icon: Icons.info),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TermsScreen(),
              ));
            },
            child: DrawerItem(
              text: "terms and conditions",
              icon: Icons.document_scanner_rounded,
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              resetDB(context);
            },
            child: DrawerItem(
              text: "reset",
              icon: Icons.restore_from_trash_outlined,
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              exitpopup(context);
            },
            child: DrawerItem(text: "exit", icon: Icons.exit_to_app),
          ),
          Divider(),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Text(
              "version : 1.0.1",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
