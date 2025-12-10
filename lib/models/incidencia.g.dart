// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incidencia.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncidenciaAdapter extends TypeAdapter<Incidencia> {
  @override
  final int typeId = 2;

  @override
  Incidencia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Incidencia(
      usuarioNombre: fields[0] as String,
      descripcion: fields[1] as String,
      fecha: fields[2] as DateTime,
      gravedad: fields[3] as Gravedad,
    );
  }

  @override
  void write(BinaryWriter writer, Incidencia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.usuarioNombre)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.gravedad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncidenciaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
