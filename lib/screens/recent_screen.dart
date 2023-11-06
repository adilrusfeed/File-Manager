// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:file_manager/db/function.dart';
import 'package:open_file/open_file.dart';

class RecentScreen extends StatefulWidget {
  RecentScreen({Key? key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  bool isGridView = false; // Default view mode is ListView

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
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton<String>(
            onSelected: (choice) {
              setState(() {
                if (choice == 'gridView') {
                  isGridView = true;
                } else if (choice == 'listView') {
                  isGridView = false;
                } else if (choice == 'sort') {
                  // Handle sorting logic
                }
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'gridView',
                  child: Text('Grid View'),
                ),
                PopupMenuItem<String>(
                  value: 'listView',
                  child: Text('List View'),
                ),
                PopupMenuItem<String>(
                  value: 'sort',
                  child: Text('Sort'),
                ),
              ];
            },
          ),
        ],
      ),
      body: isGridView ? buildGridView() : buildListView(),
    );
  }

  Widget buildListView() {
    return ValueListenableBuilder<List<FileModel>>(
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
              leading: Icon(Icons.insert_drive_file),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.drive_file_rename_outline_outlined)),
            );
          },
        );
      },
    );
  }

  Widget buildGridView() {
    return ValueListenableBuilder<List<FileModel>>(
      valueListenable: FileNotifier,
      builder: (context, files, child) {
        files = files.reversed.toList(); // Reverse the list
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // Adjust as needed
          ),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return GestureDetector(
              onTap: () {
                openFile(file);
              },
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_none_rounded),
                        Text(file.fileName),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert_outlined)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
