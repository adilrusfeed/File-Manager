// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_manager/view/main_screens/add_screen.dart';
import 'package:file_manager/view/main_screens/chart_screen.dart';
import 'package:file_manager/view/main_screens/home_screen.dart';
import 'package:file_manager/view/main_screens/recent_screen.dart';


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
    return SafeArea(
      child: Scaffold(
          body: pages[myindex],
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.white,
              color: Color.fromARGB(255, 0, 0, 0),
              animationDuration: Duration(milliseconds: 500),
              onTap: (index) {
                setState(() {
                  myindex = index;
                });
              },
              items: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.bar_chart_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ])),
    );
  }
}
