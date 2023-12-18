// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class searchcontainer extends StatelessWidget {
  ///
  const searchcontainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 236, 236),
          border:
              Border.all(width: 2, color: const Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            SizedBox(width: 15),
            Lottie.asset("assets/images/search.json"),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search Files',
                style: TextStyle(
                  color: Color.fromARGB(255, 192, 187, 187),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
