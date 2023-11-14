// ignore_for_file: prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

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
        title: Text("videos"),
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

                  if (isVideoFile(file.fileName)) {
                    return ListTile(
                      onTap: () {
                        openFile(file);
                      },
                      title: Text(file.fileName),
                      leading: Icon(Icons.insert_drive_file),
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
}
