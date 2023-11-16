// ignore: depend_on_referenced_packages
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool _isAscending = true;
  bool isAudioFile(String fileName) {
    var audioExtension = [
      '.mp3',
      '.wav',
      '.aac',
      '.ogg',
      '.wma',
      '.flac',
      '.m4a',
    ];
    var extension = path.extension(fileName).toLowerCase();
    return audioExtension.contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
        title: Text("audios"),
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
            files = files.reversed.toList();

            return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];

                  if (isAudioFile(file.fileName)) {
                    return ListTile(
                      onTap: () {
                        openFile(file);
                      },
                      title: Text(file.fileName),
                      leading: Icon(
                        Icons.audiotrack,
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
