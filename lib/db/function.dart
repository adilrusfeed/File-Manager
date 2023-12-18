// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print

import 'package:file_manager/model/data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';

ValueNotifier<List<FileModel>> FileNotifier = ValueNotifier([]);

List<FileModel> recentFiles = [];

Future<void> pickFile(PlatformFile selectedFile) async {
  final fileDB = await Hive.openBox<FileModel>("FileModel_db");
  final file = FileModel(
    id: DateTime.now().millisecondsSinceEpoch,
    fileName: selectedFile.name,
    filePath: selectedFile.path ?? '',
  );

  await fileDB.add(file);

  FileNotifier.value.add(file);
  FileNotifier.notifyListeners();
}

Future<void> getAlldata() async {
  final fileDB = await Hive.openBox<FileModel>("FileModel_db");

  FileNotifier.value.clear();
  FileNotifier.value.addAll(fileDB.values);
  FileNotifier.notifyListeners();
}

Future<void> deleteFile(FileModel file) async {
  final fileDB = await Hive.openBox<FileModel>('FileModel_db');
  final index = fileDB.values.toList().indexOf(file);
  await fileDB.deleteAt(index);
  getAlldata();
}

Future<void> renameFile1(int index, FileModel newValue) async {
  final fileDB = await Hive.openBox<FileModel>('FileModel_db');
  await fileDB.putAt(index, newValue);
  FileNotifier.value[index] = newValue;
  FileNotifier.notifyListeners();
}

Future<void> openFile(FileModel file) async {
  final filePath = file.filePath;
  final fileName = file.fileName;

  try {
    await OpenFile.open(filePath);
    print(fileName);
  } catch (error) {
    print(error);
  }
}
