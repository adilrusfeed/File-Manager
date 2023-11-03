import 'package:file_manager/bottombar.dart';
import 'package:file_manager/model/filemanager.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FileManagerAdapter().typeId)) {
    Hive.registerAdapter(FileManagerAdapter());
    await Hive.openBox<FileManager>('videos');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File organiser',
      debugShowCheckedModeBanner: false,
      home: BottomBar(),
    );
  }
}
