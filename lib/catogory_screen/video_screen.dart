// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

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
  TextEditingController searchController3 = TextEditingController();
  String searchQuery = "";

  bool _isAscending = true;

  bool isVideoFile(String fileName) {
    var videoExtensions = [
      '.mkv',
      '.mp4',
      '.avi',
      '.flv',
      '.wmv',
      '.mov',
      '.3gp',
      '.webm',
    ];
    var extension = path.extension(fileName).toLowerCase();
    return videoExtensions.contains(extension);
  }

  void onSearchTextChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text("videos"),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    const Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {
                setState(() {
                  _isAscending = !_isAscending;
                });
              },
              child: Text("sort")),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController3,
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 236, 236),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Search Files',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 151, 146, 146),
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<FileModel>>(
              valueListenable: FileNotifier,
              builder: (context, files, child) {
                List<FileModel> sortedFiles = List.from(files);
                sortedFiles.sort((a, b) {
                  return _isAscending
                      ? b.fileName.compareTo(a.fileName)
                      : a.fileName.compareTo(b.fileName);
                });

                if (searchQuery.isNotEmpty) {
                  sortedFiles = sortedFiles
                      .where((file) => file.fileName
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();
                }

                return ListView.builder(
                    itemCount: sortedFiles.length,
                    itemBuilder: (context, index) {
                      final file = sortedFiles[index];

                      if (isVideoFile(file.fileName)) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            child: ListTile(
                              onTap: () {
                                openFile(file);
                              },
                              title: Text(
                                file.fileName,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              leading: Icon(
                                Icons.video_camera_back_outlined,
                                color: Colors.orange,
                              ),
                              trailing: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          const Color.fromARGB(
                                              255, 255, 255, 255)),
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
        ],
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
