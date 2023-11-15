// ignore_for_file: prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  bool isDocumentFile(String fileName) {
    var documentExtension = [
      '.pdf',
      '.doc',
      '.txt',
      '.ppt',
      '.docx',
      '.pptx',
      '.xlxs',
      '.xls'
    ];
    var extension = path.extension(fileName).toLowerCase();
    return documentExtension.contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("documents"),
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

                  if (isDocumentFile(file.fileName)) {
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
