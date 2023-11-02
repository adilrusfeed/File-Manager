// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class searchbar extends StatelessWidget {
  const searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 240, 236, 236),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'Search Files',
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 192, 187, 187),
                fontWeight: FontWeight.w500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
