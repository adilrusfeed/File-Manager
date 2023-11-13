import 'package:file_manager/model/data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<FileModel>> FileNotifier = ValueNotifier([]);

Future<void> addFile(PlatformFile selectedFile) async {
  final fileDB = await Hive.openBox<FileModel>("FileModel_db");
  final file = FileModel(
    id: DateTime.now().millisecondsSinceEpoch,
    fileName: selectedFile.name ?? '',
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

Future<void> deleteFile(index) async {
  final fileDB = await Hive.openBox<FileModel>('FileModel_db');
  await fileDB.deleteAt(index);
  getAlldata();
}

Future<void> renameFile(int id, FileModel newValue) async {
  final fileDB = await Hive.openBox<FileModel>('FileModel_db');
  await fileDB.put(id, newValue);

  FileNotifier.value[id] = newValue;
  FileNotifier.notifyListeners();
}
