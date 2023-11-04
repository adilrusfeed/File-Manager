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
// Set a default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF45A29E),
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
            SizedBox(height: 5),
            Text("add your files here",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white)),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                pickFiless();
              },
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
                child: Center(
                    child: Text(
                  "Add files  +",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
            SizedBox(height: 20),
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
