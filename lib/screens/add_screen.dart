// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  List<PlatformFile>? selectedFiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  if (selectedFiles != null && selectedFiles!.isNotEmpty) {
                    for (var file in selectedFiles!) {
                      await addFile(file);
                    }

                    getAlldata();
                    setState(() {
                      selectedFiles = null;
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
              ),
              SizedBox(height: 10),
              Divider(),
              if (selectedFiles != null && selectedFiles!.isNotEmpty)
                Column(children: [
                  for (var file in selectedFiles!)
                    GestureDetector(
                      onTap: () {
                        openFile(file);
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
                              file.name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ]),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void pickFiless() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFiles = result.files;
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
