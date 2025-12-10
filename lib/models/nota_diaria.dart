import 'package:hive/hive.dart';

part 'nota_diaria.g.dart';

@HiveType(typeId: 0)
class NotaDiaria extends HiveObject {
  @HiveField(0)
  String texto;

  @HiveField(1)
  List<String> rutas;

  @HiveField(2)
  List<String> tipos;

  NotaDiaria({
    required this.texto,
    required this.rutas,
    required this.tipos,
  });
}
