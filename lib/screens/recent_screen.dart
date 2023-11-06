// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class RecentScreen extends StatefulWidget {
  RecentScreen({Key? key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  @override
  void initState() {
    getAlldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF45A29E),
        title: Center(
          child: Text(
            'Recents',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder<List<FileModel>>(
        valueListenable: FileNotifier,
        builder: (context, files, child) {
          files = files.reversed.toList(); // Reverse the list
          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return ListTile(
                onTap: () {
                  openFile(file);
                },
                title: Text(file.fileName),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> openFile(FileModel file) async {
    final filePath = file.filePath;

    try {
      await OpenFile.open(filePath);
    } catch (error) {
      print(error);
    }
  }
}
