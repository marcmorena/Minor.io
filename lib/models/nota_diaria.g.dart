// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_diaria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotaDiariaAdapter extends TypeAdapter<NotaDiaria> {
  @override
  final int typeId = 0;

  @override
  NotaDiaria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotaDiaria(
      texto: fields[0] as String,
      rutas: (fields[1] as List).cast<String>(),
      tipos: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotaDiaria obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.texto)
      ..writeByte(1)
      ..write(obj.rutas)
      ..writeByte(2)
      ..write(obj.tipos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotaDiariaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
