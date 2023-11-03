// import 'package:file_manager/model/filemanager.dart';
// import 'package:hive/hive.dart';

// class FileRepository {
//   final Future<Box<FileManager>> _file =Hive.openBox<FileManager>('File');

//  Future<void> addSub(subdata value) async{

//   final subDB= await Hive.openBox<FileManager>("subdata_db");
//   await subDB.add(value);
 
// }
// Future<void> getAlldata()async{
//   final subDB= await Hive.openBox<FileManager>("subdata_db");
//   SubListNotifier.value.clear();
//   SubListNotifier.value.addAll(subDB.values);
//   SubListNotifier.notifyListeners();
// }
// }