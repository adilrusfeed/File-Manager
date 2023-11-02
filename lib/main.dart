import 'package:file_manager/bottombar.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File organiser',
      debugShowCheckedModeBanner: false,
      home: BottomBar(),
    );
  }
}
