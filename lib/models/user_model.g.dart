// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 10;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      categoria: fields[36] as String,
      nombreCompleto: fields[0] as String,
      fechaNacimiento: fields[1] as String,
      edad: fields[2] as String,
      sexo: fields[3] as String,
      nacionalidad: fields[4] as String,
      lugarNacimiento: fields[5] as String,
      numeroExpediente: fields[6] as String,
      fechaIngreso: fields[7] as String,
      fechaEgreso: fields[8] as String,
      motivoIngreso: fields[9] as String,
      nombrePadres: fields[10] as String,
      relacionPadres: fields[11] as String,
      situacionSocioeconomica: fields[12] as String,
      contactoFamiliar: fields[13] as String,
      estadoSalud: fields[14] as String,
      diagnosticos: fields[15] as String,
      medicacion: fields[16] as String,
      historialConsumo: fields[17] as String,
      diagnosticoPsicologico: fields[18] as String,
      seguimientoTerapeutico: fields[19] as String,
      nivelEducativo: fields[20] as String,
      escolarizacionActual: fields[21] as String,
      habilidadesFormativas: fields[22] as String,
      participacionTalleres: fields[23] as String,
      comportamientoGeneral: fields[24] as String,
      incidentesRelevantes: fields[25] as String,
      relacionEquipoEducativo: fields[26] as String,
      participacionActividades: fields[27] as String,
      fortalezasPersonales: fields[28] as String,
      areasAMejorar: fields[29] as String,
      evolucionTiempo: fields[30] as String,
      medidaJudicialVigente: fields[31] as String,
      historialJudicial: fields[32] as String,
      contactoSistemaJudicial: fields[33] as String,
      valoracionesEquipo: fields[34] as String,
      sugerenciasSeguimiento: fields[35] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(37)
      ..writeByte(36)
      ..write(obj.categoria)
      ..writeByte(0)
      ..write(obj.nombreCompleto)
      ..writeByte(1)
      ..write(obj.fechaNacimiento)
      ..writeByte(2)
      ..write(obj.edad)
      ..writeByte(3)
      ..write(obj.sexo)
      ..writeByte(4)
      ..write(obj.nacionalidad)
      ..writeByte(5)
      ..write(obj.lugarNacimiento)
      ..writeByte(6)
      ..write(obj.numeroExpediente)
      ..writeByte(7)
      ..write(obj.fechaIngreso)
      ..writeByte(8)
      ..write(obj.fechaEgreso)
      ..writeByte(9)
      ..write(obj.motivoIngreso)
      ..writeByte(10)
      ..write(obj.nombrePadres)
      ..writeByte(11)
      ..write(obj.relacionPadres)
      ..writeByte(12)
      ..write(obj.situacionSocioeconomica)
      ..writeByte(13)
      ..write(obj.contactoFamiliar)
      ..writeByte(14)
      ..write(obj.estadoSalud)
      ..writeByte(15)
      ..write(obj.diagnosticos)
      ..writeByte(16)
      ..write(obj.medicacion)
      ..writeByte(17)
      ..write(obj.historialConsumo)
      ..writeByte(18)
      ..write(obj.diagnosticoPsicologico)
      ..writeByte(19)
      ..write(obj.seguimientoTerapeutico)
      ..writeByte(20)
      ..write(obj.nivelEducativo)
      ..writeByte(21)
      ..write(obj.escolarizacionActual)
      ..writeByte(22)
      ..write(obj.habilidadesFormativas)
      ..writeByte(23)
      ..write(obj.participacionTalleres)
      ..writeByte(24)
      ..write(obj.comportamientoGeneral)
      ..writeByte(25)
      ..write(obj.incidentesRelevantes)
      ..writeByte(26)
      ..write(obj.relacionEquipoEducativo)
      ..writeByte(27)
      ..write(obj.participacionActividades)
      ..writeByte(28)
      ..write(obj.fortalezasPersonales)
      ..writeByte(29)
      ..write(obj.areasAMejorar)
      ..writeByte(30)
      ..write(obj.evolucionTiempo)
      ..writeByte(31)
      ..write(obj.medidaJudicialVigente)
      ..writeByte(32)
      ..write(obj.historialJudicial)
      ..writeByte(33)
      ..write(obj.contactoSistemaJudicial)
      ..writeByte(34)
      ..write(obj.valoracionesEquipo)
      ..writeByte(35)
      ..write(obj.sugerenciasSeguimiento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
