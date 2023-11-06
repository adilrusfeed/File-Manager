import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:file_manager/bottombar.dart';
import 'package:file_manager/model/data_model.dart'; // Import your FileModel

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(FileModelAdapter());

  await Hive.openBox<FileModel>("FileModel_db");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File organiser',
      debugShowCheckedModeBanner: false,
      home: BottomBar(),
    );
  }
}
