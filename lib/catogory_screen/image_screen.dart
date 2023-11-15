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
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        title: Text('Images'),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.brown),
              ),
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
                    trailing: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                const Color.fromARGB(255, 255, 255, 255)),
                            shape: MaterialStatePropertyAll(
                                CircleBorder(eccentricity: 0))),
                        onPressed: () {
                          _deleteDialog(file);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteDialog(FileModel file) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${file.fileName}?',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteFile(file);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
