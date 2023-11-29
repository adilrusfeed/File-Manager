//clear from db - reset

// ignore_for_file: use_build_context_synchronously

import 'package:file_manager/widgets/bottombar.dart';
import 'package:file_manager/model/data_model.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future<void> resetDB(
  BuildContext context,
) async {
  bool confirmReset = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Confirm Reset",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Are you sure you want to reset app\nDelete all files!",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.orange.shade700),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.orange.shade700),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmReset == true) {
    final filedb = await Hive.openBox<FileModel>('FileModel_db');
    filedb.clear();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomBar(),
        ));
  }
}
