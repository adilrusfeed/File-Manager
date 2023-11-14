// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'ANALYSE',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(children: [
        Center(
          child: Text(
            "storage details",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 25),
        Text(
          "here you can know how many files you added ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Image.asset("assets/images/Screenshot 2023-11-14 112058.png")
      ]),
    );
  }
}
