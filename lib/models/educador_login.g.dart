// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'educador_login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducadorLoginAdapter extends TypeAdapter<EducadorLogin> {
  @override
  final int typeId = 5;

  @override
  EducadorLogin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducadorLogin(
      nombre: fields[0] as String,
      password: fields[1] as String,
      nombreReal: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EducadorLogin obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.nombreReal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducadorLoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
