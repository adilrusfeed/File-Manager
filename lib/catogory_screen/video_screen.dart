// ignore_for_file: prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool _isAscending = true;

  bool isVideoFile(String fileName) {
    var videoExtension = [
      '.mkv',
      '.mp4',
      '.avi',
      '.flv',
      '.wmv',
      '.mov',
      '.3gp',
      '.webm'
    ];
    var extension = path.extension(fileName).toLowerCase();
    return videoExtension.contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        title: Text("videos"),
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
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];

                  if (isVideoFile(file.fileName)) {
                    return Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        child: ListTile(
                          onTap: () {
                            openFile(file);
                          },
                          title: Text(file.fileName),
                          leading: Icon(
                            Icons.video_camera_back_outlined,
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
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
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
