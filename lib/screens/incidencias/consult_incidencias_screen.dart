import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:minor_io/models/incidencia.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class ConsultIncidenciasScreen extends StatefulWidget {
  const ConsultIncidenciasScreen({super.key});

  @override
  State<ConsultIncidenciasScreen> createState() => _ConsultIncidenciasScreenState();
}

class _ConsultIncidenciasScreenState extends State<ConsultIncidenciasScreen> {
  late Box<Incidencia> _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box<Incidencia>('incidencias');
  }

  void _mostrarDetalle(Incidencia incidencia, int index) {
    final fechaFormateada = DateFormat('yyyy-MM-dd').format(incidencia.fecha);
    final tipoGravedad = _formatearGravedad(incidencia.gravedad);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Incidencia de ${incidencia.usuarioNombre}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tipo: $tipoGravedad", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Fecha: $fechaFormateada", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Descripción:", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              Text(incidencia.descripcion, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              _box.deleteAt(index);
              Navigator.pop(context);
              setState(() {});
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Eliminar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String _formatearGravedad(Gravedad gravedad) {
    switch (gravedad) {
      case Gravedad.leve:
        return 'Leve';
      case Gravedad.moderada:
        return 'Moderada';
      case Gravedad.grave:
        return 'Grave';
    }
  }

  @override
  Widget build(BuildContext context) {
    final incidencias = _box.values.toList().cast<Incidencia>();
    incidencias.sort((a, b) => b.fecha.compareTo(a.fecha));

    return BaseScaffold(
      appBar: AppBar(title: const Text("Incidencias Registradas",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: incidencias.isEmpty
          ? const Center(child: Text("No hay incidencias registradas."))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: incidencias.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final incidencia = incidencias[index];
                final fechaFormateada = DateFormat('yyyy-MM-dd').format(incidencia.fecha);
                final tipoGravedad = _formatearGravedad(incidencia.gravedad);

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.report_problem, color: Colors.red),
                    title: Text(incidencia.usuarioNombre, style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text("$fechaFormateada - $tipoGravedad", style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () => _mostrarDetalle(incidencia, index),
                  ),
                );
              },
            ),
    );
  }
}
