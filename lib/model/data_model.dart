import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class FileModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String fileName;
  @HiveField(2)
  String filePath;

  FileModel({required this.id, required this.fileName, required this.filePath});
}
