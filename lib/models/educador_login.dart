import 'package:hive/hive.dart';

part 'educador_login.g.dart';

@HiveType(typeId: 5)
class EducadorLogin extends HiveObject {
  @HiveField(0)
  final String nombre;

  @HiveField(1)
  final String password;

  @HiveField(2)
final String nombreReal;


  EducadorLogin({required this.nombre, required this.password, required this.nombreReal,});
}
