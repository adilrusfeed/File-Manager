// import 'package:file_manager/model/data_model.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';

// ValueNotifier<List<FileManager>> fileManagerNotifier = ValueNotifier([]);
// Future<void> addData(FileManager value) async {
//   final dataDB = await Hive.openBox<FileManager>('data_db');
//   await dataDB.add(value);
//   fileManagerNotifier.value.add(value);
//   fileManagerNotifier.notifyListeners();
// }

// Future<void> getAlldata() async {
//   final dataDB = await Hive.openBox<FileManager>('data_db');
//   fileManagerNotifier.value.clear();
//   fileManagerNotifier.value.addAll(dataDB.values);
//   fileManagerNotifier.notifyListeners();
// }
