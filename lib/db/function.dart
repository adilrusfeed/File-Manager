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

Future<void> renameFile(FileModel file, String newName) async {
  try {
    file.setFileName(newName);
    final fileDB = await Hive.openBox<FileModel>("FileModel_db");
    await fileDB.put(file.id, file);

    FileNotifier.value =
        FileNotifier.value.map((f) => f.id == file.id ? file : f).toList();
    FileNotifier.notifyListeners();
  } catch (e) {
    print('Error in renaming the file:$e');
  }
}

Future<void> deleteFile(FileModel file) async {
  try {
    final fileDB = await Hive.openBox<FileModel>("FileModel_db");
    await fileDB.delete(file.id);

    FileNotifier.value.removeWhere((f) => f.id == file.id);
    FileNotifier.notifyListeners();
  } catch (e) {
    print('Error in deleting the file:$e');
  }
}
