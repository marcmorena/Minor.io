import 'package:hive/hive.dart';
import '../models/incidencia.dart';

class GravedadAdapter extends TypeAdapter<Gravedad> {
  @override
  final int typeId = 4;

  @override
  Gravedad read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gravedad.leve;
      case 1:
        return Gravedad.moderada;
      case 2:
        return Gravedad.grave;
      default:
        return Gravedad.leve;
    }
  }

  @override
  void write(BinaryWriter writer, Gravedad obj) {
    switch (obj) {
      case Gravedad.leve:
        writer.writeByte(0);
        break;
      case Gravedad.moderada:
        writer.writeByte(1);
        break;
      case Gravedad.grave:
        writer.writeByte(2);
        break;
    }
  }
}
