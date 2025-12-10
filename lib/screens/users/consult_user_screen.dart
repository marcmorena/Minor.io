import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class ConsultUsersScreen extends StatelessWidget {
  final String category;

  const ConsultUsersScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<UserModel>('usuarios');
    final usuarios = box.values
        .where((user) => user.categoria.toLowerCase() == category.toLowerCase())
        .toList();

    return BaseScaffold(
      appBar: AppBar(title: Text("Usuarios - $category",
          style: const TextStyle(fontWeight: FontWeight.bold))),
      body: usuarios.isEmpty
          ? const Center(child: Text("No hay usuarios registrados."))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: usuarios.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      usuario.nombreCompleto,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Edad: ${usuario.edad}  •  Sexo: ${usuario.sexo}"),
                        Text(
                          "Motivo ingreso: ${usuario.motivoIngreso}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    onTap: () => _mostrarDetallesUsuario(context, usuario),
                    onLongPress: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("¿Eliminar usuario?"),
                          content: Text("¿Estás seguro de eliminar a ${usuario.nombreCompleto}?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        usuario.delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Usuario eliminado")),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }

  void _mostrarDetallesUsuario(BuildContext context, UserModel usuario) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        scrollable: true,
        title: Text(usuario.nombreCompleto),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Información Personal", {
              "Fecha de nacimiento": usuario.fechaNacimiento,
              "Edad": usuario.edad,
              "Sexo": usuario.sexo,
              "Nacionalidad": usuario.nacionalidad,
              "Lugar de nacimiento": usuario.lugarNacimiento,
              "Número de expediente": usuario.numeroExpediente,
              "Fecha de ingreso": usuario.fechaIngreso,
              "Fecha de egreso": usuario.fechaEgreso,
              "Motivo de ingreso": usuario.motivoIngreso,
            }),
            _buildSection("Familia y Entorno", {
              "Nombre de los padres": usuario.nombrePadres,
              "Relación con los padres": usuario.relacionPadres,
              "Situación socioeconómica": usuario.situacionSocioeconomica,
              "Contacto familiar": usuario.contactoFamiliar,
            }),
            _buildSection("Salud", {
              "Estado de salud": usuario.estadoSalud,
              "Diagnósticos": usuario.diagnosticos,
              "Medicación": usuario.medicacion,
              "Historial de consumo": usuario.historialConsumo,
              "Diagnóstico psicológico": usuario.diagnosticoPsicologico,
              "Seguimiento terapéutico": usuario.seguimientoTerapeutico,
            }),
            _buildSection("Educación", {
              "Nivel educativo": usuario.nivelEducativo,
              "Escolarización actual": usuario.escolarizacionActual,
              "Habilidades formativas": usuario.habilidadesFormativas,
              "Participación en talleres": usuario.participacionTalleres,
            }),
            _buildSection("Conducta", {
              "Comportamiento general": usuario.comportamientoGeneral,
              "Incidentes relevantes": usuario.incidentesRelevantes,
              "Relación con equipo educativo": usuario.relacionEquipoEducativo,
              "Participación en actividades": usuario.participacionActividades,
            }),
            _buildSection("Evaluación Psicosocial", {
              "Fortalezas personales": usuario.fortalezasPersonales,
              "Áreas a mejorar": usuario.areasAMejorar,
              "Evolución en el tiempo": usuario.evolucionTiempo,
            }),
            _buildSection("Medidas Judiciales", {
              "Medida judicial vigente": usuario.medidaJudicialVigente,
              "Historial judicial": usuario.historialJudicial,
              "Contacto con sistema judicial": usuario.contactoSistemaJudicial,
            }),
            _buildSection("Observaciones", {
              "Valoraciones del equipo": usuario.valoracionesEquipo,
              "Sugerencias de seguimiento": usuario.sugerenciasSeguimiento,
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cerrar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Map<String, String> fields) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: fields.entries
          .map((entry) => ListTile(
                dense: true,
                title: Text("${entry.key}:"),
                subtitle: Text(entry.value),
              ))
          .toList(),
    );
  }
}