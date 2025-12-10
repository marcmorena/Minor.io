import 'package:hive/hive.dart';

part 'actividad.g.dart';

@HiveType(typeId: 3)
class Actividad extends HiveObject {
  @HiveField(0)
  String titulo;

  @HiveField(1)
  String descripcion;

  @HiveField(2)
  final DateTime fecha;

  @HiveField(3)
  List<String> participantes;

  @HiveField(4)
  String educadorCodigo;

  @HiveField(5)
  bool completada;

  Actividad({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.participantes,
    required this.educadorCodigo,
    this.completada = false,
  });
}
