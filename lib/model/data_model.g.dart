// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileManagerAdapter extends TypeAdapter<FileManager> {
  @override
  final int typeId = 0;

  @override
  FileManager read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileManager(
      videopath: fields[3] as String?,
      name: fields[1] as String?,
      documentpath: fields[5] as String?,
      imagepath: fields[2] as String?,
      musicpath: fields[4] as String?,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FileManager obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imagepath)
      ..writeByte(3)
      ..write(obj.videopath)
      ..writeByte(4)
      ..write(obj.musicpath)
      ..writeByte(5)
      ..write(obj.documentpath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileManagerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
