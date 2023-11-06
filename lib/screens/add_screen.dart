// ignore_for_file: prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  PlatformFile? selectedFile; // Store the selected file

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
            colors: [
              Color(0xFF45A29E),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedFile != null) // Display the selected file
              GestureDetector(
                onTap: () {
                  openFile(selectedFile!);
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Selected File:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        selectedFile!.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    "Add files",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            FloatingActionButton.extended(
              backgroundColor: Colors.orangeAccent,
              onPressed: () async {
                if (selectedFile != null) {
                  await addFile(selectedFile!);
                  getAlldata();
                  setState(() {
                    selectedFile = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 200),
                    content: Text(
                      "Added Successfully",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.white,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 200),
                    content: Text(
                      "Select a File",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.white,
                  ));
                }
              },
              label: Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  void pickFiless() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  Future<void> openFile(PlatformFile file) async {
    final filePath = file.path;
    final fileName = file.name;

    try {
      await OpenFile.open(filePath);
      print(fileName);
    } catch (error) {
      print(error);
    }
  }
}
