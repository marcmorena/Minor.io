import 'package:hive/hive.dart';

part 'incidencia.g.dart';

enum Gravedad { leve, moderada, grave }

@HiveType(typeId: 2)
class Incidencia extends HiveObject {
  @HiveField(0)
  final String usuarioNombre;

  @HiveField(1)
  final String descripcion;

  @HiveField(2)
  final DateTime fecha;

  @HiveField(3)
  final Gravedad gravedad;

  Incidencia({
    required this.usuarioNombre,
    required this.descripcion,
    required this.fecha,
    required this.gravedad,
  });
}

