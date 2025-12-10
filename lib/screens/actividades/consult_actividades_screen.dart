import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:minor_io/models/actividad.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class ConsultActividadesScreen extends StatefulWidget {
  const ConsultActividadesScreen({super.key});

  @override
  State<ConsultActividadesScreen> createState() => _ConsultActividadesScreenState();
}

class _ConsultActividadesScreenState extends State<ConsultActividadesScreen> {
  late Box<Actividad> _actividadBox;

  @override
  void initState() {
    super.initState();
    _actividadBox = Hive.box<Actividad>('actividades');
  }

  String _obtenerEstado(Actividad actividad) {
    final hoy = DateTime.now();
    final fecha = actividad.fecha;

    if (fecha.isAfter(hoy)) return 'Pendiente';
    if (fecha.year == hoy.year && fecha.month == hoy.month && fecha.day == hoy.day) {
      return 'En curso';
    }
    return 'Finalizada';
  }

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'Pendiente':
        return Colors.green;
      case 'En curso':
        return Colors.orange;
      case 'Finalizada':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  void _mostrarDetalles(BuildContext context, Actividad actividad) {
    final estado = _obtenerEstado(actividad);
    final fechaFormateada = DateFormat('yyyy-MM-dd').format(actividad.fecha);
    final partesDescripcion = actividad.descripcion.split("\n");
    final descripcion = partesDescripcion.first;
    final horario = partesDescripcion.length > 1 ? partesDescripcion.last : null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          actividad.titulo,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descripción:",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(descripcion, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 12),

              Text(
                "Fecha: $fechaFormateada", 
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              if (horario != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Horario: $horario", 
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              ],
              const SizedBox(height: 12),
              Text(
                "Participantes:",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(actividad.participantes.join(', '), style: Theme.of(context).textTheme.bodyLarge),

              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "Estado: ", 
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
                  Text(
                    estado,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: _colorEstado(estado),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _eliminarActividad(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar Actividad"),
        content: const Text("¿Estás seguro de que deseas eliminar esta actividad?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () {
              _actividadBox.deleteAt(index);
              Navigator.pop(context);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Actividad eliminada")),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Eliminar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actividades = _actividadBox.values.toList().cast<Actividad>();
    actividades.sort((a, b) => b.fecha.compareTo(a.fecha));

    return BaseScaffold(
      appBar: AppBar(title: const Text("Consultar Actividades",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: actividades.isEmpty
          ? const Center(child: Text("No hay actividades registradas"))
          : ListView.builder(
              itemCount: actividades.length,
              itemBuilder: (context, index) {
                final actividad = actividades[index];
                final estado = _obtenerEstado(actividad);
                final fechaFormateada = DateFormat('yyyy-MM-dd').format(actividad.fecha);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      actividad.titulo,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text("Fecha: $fechaFormateada"),
                    trailing: Text(
                      estado,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _colorEstado(estado),
                      ),
                    ),
                    onTap: () => _mostrarDetalles(context, actividad),
                    onLongPress: () => _eliminarActividad(index),
                  ),
                );
              },
            ),
    );
  }
}
