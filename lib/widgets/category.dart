import 'package:flutter/material.dart';

class categoryContainer extends StatelessWidget {
  const categoryContainer({
    super.key,
    required this.imagePath,
    required this.containerText,
  });

  final String imagePath;
  final String containerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 125,
          width: 110,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(
                      color: Color.fromARGB(255, 227, 226, 226), width: 2),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                containerText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
