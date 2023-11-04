import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class FileManager extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? imagepath;
  @HiveField(3)
  String? videopath;
  @HiveField(4)
  String? musicpath;
  @HiveField(5)
  String? documentpath;

  File? file;

  FileManager(
      {required this.videopath,
      required this.name,
      required this.documentpath,
      required this.imagepath,
      required this.musicpath,
      this.id});
}
