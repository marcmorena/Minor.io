// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actividad.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActividadAdapter extends TypeAdapter<Actividad> {
  @override
  final int typeId = 3;

  @override
  Actividad read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Actividad(
      titulo: fields[0] as String,
      descripcion: fields[1] as String,
      fecha: fields[2] as DateTime,
      participantes: (fields[3] as List).cast<String>(),
      educadorCodigo: fields[4] as String,
      completada: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Actividad obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.participantes)
      ..writeByte(4)
      ..write(obj.educadorCodigo)
      ..writeByte(5)
      ..write(obj.completada);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActividadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
