// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String selectedCategory = " "; // Set a default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF45A29E),
        title: Center(
          child: Text(
            'ADD',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF45A29E), Color(0xFF2F496E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Add Files",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                height: 66,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 236, 236),
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(255, 69, 64, 64),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$selectedCategory",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              hoverColor: Color.fromARGB(255, 0, 0, 0),
              onTap: () {
                pickFiless();
              },
              child: Container(
                width: 150,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 221, 222),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                child: Center(
                    child: Text(
                  "Add files",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickFiless() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result == null || result.files.isEmpty) return;

    for (var file in result.files) {
      viewFile(file);
    }
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
