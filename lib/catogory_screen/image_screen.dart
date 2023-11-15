// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool _isAscending = true;

  bool isImageFile(String fileName) {
    var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    var extension = path.extension(fileName).toLowerCase();
    return imageExtensions.contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _isAscending = !_isAscending;
                });
              },
              child: Text("sort")),
        ],
      ),
      body: Container(
        child: ValueListenableBuilder<List<FileModel>>(
          valueListenable: FileNotifier,
          builder: (context, files, child) {
            List<FileModel> sortedFiles = List.from(files);
            sortedFiles.sort((a, b) {
              return _isAscending
                  ? b.fileName.compareTo(a.fileName)
                  : a.fileName.compareTo(b.fileName);
            });

            return ListView.builder(
              itemCount: sortedFiles.length,
              itemBuilder: (context, index) {
                final file = sortedFiles[index];

                if (isImageFile(file.fileName)) {
                  return ListTile(
                    onTap: () {
                      openFile(file);
                    },
                    title: Text(file.fileName),
                    leading: Icon(
                      Icons.image,
                      color: Colors.orange,
                    ),
                  );
                } else {
                  return Container(); // Filter out non-image files
                }
              },
            );
          },
        ),
      ),
    );
  }
}
