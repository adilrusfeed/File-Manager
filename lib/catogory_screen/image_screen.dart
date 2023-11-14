// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key});

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

                if (isImageFile(file.fileName)) {
                  return ListTile(
                    onTap: () {
                      openFile(file);
                    },
                    title: Text(file.fileName),
                    leading: Icon(Icons.insert_drive_file),
                    // trailing: PopupMenuButton<String>(
                    //   onSelected: (choice) {
                    //     if (choice == "rename") {
                    //       renameFile(index, file);
                    //     } else if (choice == "delete") {
                    //       deleteFile(file);
                    //     }
                    //   },
                    //   itemBuilder: (BuildContext context) {
                    //     return [
                    //       PopupMenuItem<String>(
                    //         value: 'rename',
                    //         child: Text('Rename'),
                    //       ),
                    //       PopupMenuItem<String>(
                    //         value: 'delete',
                    //         child: Text('Delete'),
                    //       ),
                    //     ];
                    //   },
                    // ),
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
