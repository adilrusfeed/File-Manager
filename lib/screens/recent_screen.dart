// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';

class RecentScreen extends StatefulWidget {
  RecentScreen({Key? key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  PlatformFile? selectedFile;
  TextEditingController searchController = TextEditingController();

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
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return ListTile(
                  onTap: () {
                    openFile(selectedFile!);
                  },
                  title: Text(file.fileName),
                );
              },
            );
          }),
    );
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
