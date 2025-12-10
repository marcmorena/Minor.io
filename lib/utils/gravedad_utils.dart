import '../models/incidencia.dart';

Gravedad gravedadFromString(String tipo) {
  switch (tipo.toLowerCase()) {
    case 'leve':
      return Gravedad.leve;
    case 'moderada':
      return Gravedad.moderada;
    case 'grave':
      return Gravedad.grave;
    default:
      return Gravedad.leve;
  }
}

String gravedadToString(Gravedad g) {
  switch (g) {
    case Gravedad.leve:
      return 'Leve';
    case Gravedad.moderada:
      return 'Moderada';
    case Gravedad.grave:
      return 'Grave';
  }
}
