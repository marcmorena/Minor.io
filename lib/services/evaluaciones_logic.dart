import 'package:hive/hive.dart';
import 'package:minor_io/models/actividad.dart';
import 'package:minor_io/models/incidencia.dart';
import 'package:intl/intl.dart';

enum Periodo { dia, semana, mes }

class EvaluacionService {
  final Box<Actividad> _boxActividades = Hive.box<Actividad>('actividades');
  final Box<Incidencia> _boxIncidencias = Hive.box<Incidencia>('incidencias');

  List<Actividad> obtenerActividadesPorUsuario(String nombreUsuario) {
    return _boxActividades.values
        .where((actividad) => actividad.participantes.contains(nombreUsuario))
        .toList();
  }

  List<Incidencia> obtenerIncidenciasPorUsuario(String nombreUsuario) {
    return _boxIncidencias.values
        .where((incidencia) => incidencia.usuarioNombre == nombreUsuario)
        .toList();
  }

  Map<String, int> agruparPorPeriodo(
      List<dynamic> elementos, Periodo periodo, DateTime Function(dynamic) getFecha) {
    Map<String, int> resultado = {};

    for (var elem in elementos) {
      final fecha = getFecha(elem);
      String clave = _formatearFechaSegunPeriodo(fecha, periodo);
      resultado.update(clave, (value) => value + 1, ifAbsent: () => 1);
    }

    return resultado;
  }

  String _formatearFechaSegunPeriodo(DateTime fecha, Periodo periodo) {
    switch (periodo) {
      case Periodo.dia:
        return DateFormat('yyyy-MM-dd').format(fecha);
      case Periodo.semana:
        final semana = DateFormat('yyyy-ww').format(fecha);
        return 'Semana $semana';
      case Periodo.mes:
        return DateFormat('yyyy-MM').format(fecha);
    }
  }
}
