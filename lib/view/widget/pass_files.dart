// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class passfiles extends StatelessWidget {
  const passfiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FileModel>>(
      valueListenable: FileNotifier,
      builder: (context, recentFiles, child) {
        final limitedFiles = recentFiles.take(5).toList();
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: limitedFiles.length,
              itemBuilder: (context, index) => Card(
                elevation: 4,
                child: GestureDetector(
                  onTap: () {
                    openFile(limitedFiles[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      color: Color.fromARGB(208, 255, 147, 7),
                    ),
                    child: ListTile(
                      title: Text(limitedFiles[index].fileName),
                    ),
                  ),
                ),
              ),
            ),
            if (recentFiles.isEmpty)
              Lottie.asset("assets/images/empty lottie.json", height: 250),
          ],
        );
      },
    );
  }
}
