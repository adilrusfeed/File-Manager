// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:file_manager/screens/add_screen.dart';
import 'package:file_manager/screens/chart_screen.dart';
import 'package:file_manager/screens/home_screen.dart';
import 'package:file_manager/screens/recent_screen.dart';

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int myindex = 0;

  final pages = [HomeScreen(), RecentScreen(), AddScreen(), ChartScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[myindex],
        bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Color.fromARGB(255, 152, 154, 154),
            animationDuration: Duration(milliseconds: 500),
            onTap: (index) {
              setState(() {
                myindex = index;
              });
            },
            items: [
              Icon(Icons.home),
              Icon(Icons.history),
              Icon(Icons.add),
              Icon(Icons.bar_chart_sharp),
            ]));
  }
}
