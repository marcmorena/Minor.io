import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minor_io/models/incidencia.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:minor_io/services/evaluaciones_logic.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:minor_io/widgets/grafica_barras.dart' as barras;
import 'package:minor_io/widgets/grafica_incidencias_comparativa.dart' as incidencias;

class EvaluacionesScreen extends StatefulWidget {
  const EvaluacionesScreen({super.key});

  @override
  State<EvaluacionesScreen> createState() => _EvaluacionesScreenState();
}

class _EvaluacionesScreenState extends State<EvaluacionesScreen> {
  final EvaluacionService _evaluacionService = EvaluacionService();
  String? _usuarioSeleccionado;
  final List<String> _usuariosDisponibles = [];

  Map<String, int> _datosActividades = {};
  Map<String, int> _incidenciasLeves = {};
  Map<String, int> _incidenciasModeradas = {};
  Map<String, int> _incidenciasGraves = {};
  Periodo _periodoSeleccionado = Periodo.semana;

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  void _cargarUsuarios() {
    final box = Hive.box<UserModel>('usuarios');
    _usuariosDisponibles.clear();
    _usuariosDisponibles.addAll(box.values.map((u) => u.nombreCompleto));
  }

  void _actualizarDatos() {
    final usuario = _usuarioSeleccionado;
    if (usuario == null) return;

    final actividades = _evaluacionService.obtenerActividadesPorUsuario(usuario);
    final incidencias = _evaluacionService.obtenerIncidenciasPorUsuario(usuario);

    setState(() {
      _datosActividades = _evaluacionService.agruparPorPeriodo(
        actividades,
        _periodoSeleccionado,
        (actividad) => actividad.fecha,
      );

      _incidenciasLeves = _evaluacionService.agruparPorPeriodo(
        incidencias.where((i) => i.gravedad == Gravedad.leve).toList(),
        _periodoSeleccionado,
        (incidencia) => incidencia.fecha,
      );

      _incidenciasModeradas = _evaluacionService.agruparPorPeriodo(
        incidencias.where((i) => i.gravedad == Gravedad.moderada).toList(),
        _periodoSeleccionado,
        (incidencia) => incidencia.fecha,
      );

      _incidenciasGraves = _evaluacionService.agruparPorPeriodo(
        incidencias.where((i) => i.gravedad == Gravedad.grave).toList(),
        _periodoSeleccionado,
        (incidencia) => incidencia.fecha,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('Evaluaciones de Usuarios', 
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Filtrar por usuario y periodo",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                              border: OutlineInputBorder(),
                            ),
                            value: _usuarioSeleccionado,
                            style: Theme.of(context).textTheme.bodyMedium,
                            items: _usuariosDisponibles
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _usuarioSeleccionado = value;
                              });
                              _actualizarDatos();
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        DropdownButton<Periodo>(
                          value: _periodoSeleccionado,
                          style: Theme.of(context).textTheme.bodyMedium,
                          items: Periodo.values
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(
                                    p.name.toUpperCase(),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _periodoSeleccionado = value!;
                            });
                            _actualizarDatos();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_datosActividades.isNotEmpty)
                      barras.GraficaBarras(
                        datos: _datosActividades,
                        titulo: 'Actividades realizadas',
                        color: Colors.blue,
                      ),
                    const SizedBox(height: 24),
                    if (_incidenciasLeves.isNotEmpty ||
                        _incidenciasModeradas.isNotEmpty ||
                        _incidenciasGraves.isNotEmpty)
                      incidencias.GraficaIncidenciasComparativa(
                        leves: _incidenciasLeves,
                        moderadas: _incidenciasModeradas,
                        graves: _incidenciasGraves,
                      ),
                    if (_datosActividades.isEmpty &&
                        _incidenciasLeves.isEmpty &&
                        _incidenciasModeradas.isEmpty &&
                        _incidenciasGraves.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: Text("No hay datos disponibles para este usuario en el periodo seleccionado."),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
