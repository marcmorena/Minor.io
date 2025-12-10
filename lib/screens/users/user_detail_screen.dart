import 'package:flutter/material.dart';
import 'package:minor_io/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.nombreCompleto),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section("Información Personal", {
                "Fecha de nacimiento": user.fechaNacimiento,
                "Edad": user.edad,
                "Sexo": user.sexo,
                "Nacionalidad": user.nacionalidad,
                "Lugar de nacimiento": user.lugarNacimiento,
                "Número de expediente": user.numeroExpediente,
                "Fecha de ingreso": user.fechaIngreso,
                "Fecha de egreso": user.fechaEgreso,
                "Motivo de ingreso": user.motivoIngreso,
              }),
              _section("Familia y Entorno", {
                "Nombre de los padres": user.nombrePadres,
                "Relación con los padres": user.relacionPadres,
                "Situación socioeconómica": user.situacionSocioeconomica,
                "Contacto familiar": user.contactoFamiliar,
              }),
              _section("Salud", {
                "Estado de salud": user.estadoSalud,
                "Diagnósticos": user.diagnosticos,
                "Medicación": user.medicacion,
                "Historial de consumo": user.historialConsumo,
                "Diagnóstico psicológico": user.diagnosticoPsicologico,
                "Seguimiento terapéutico": user.seguimientoTerapeutico,
              }),
              _section("Educación", {
                "Nivel educativo": user.nivelEducativo,
                "Escolarización actual": user.escolarizacionActual,
                "Habilidades formativas": user.habilidadesFormativas,
                "Participación en talleres": user.participacionTalleres,
              }),
              _section("Conducta", {
                "Comportamiento general": user.comportamientoGeneral,
                "Incidentes relevantes": user.incidentesRelevantes,
                "Relación con equipo educativo": user.relacionEquipoEducativo,
                "Participación en actividades": user.participacionActividades,
              }),
              _section("Evaluación Psicosocial", {
                "Fortalezas personales": user.fortalezasPersonales,
                "Áreas a mejorar": user.areasAMejorar,
                "Evolución en el tiempo": user.evolucionTiempo,
              }),
              _section("Medidas Judiciales", {
                "Medida judicial vigente": user.medidaJudicialVigente,
                "Historial judicial": user.historialJudicial,
                "Contacto con sistema judicial": user.contactoSistemaJudicial,
              }),
              _section("Observaciones", {
                "Valoraciones del equipo": user.valoracionesEquipo,
                "Sugerencias de seguimiento": user.sugerenciasSeguimiento,
              }),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cerrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.indigo)),
          const SizedBox(height: 4),
          ...data.entries.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text("${e.key}: ${e.value}"),
            ),
          ),
        ],
      ),
    );
  }
}
