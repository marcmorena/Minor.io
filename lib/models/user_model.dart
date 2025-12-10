import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 10)
class UserModel extends HiveObject {
  // Información General
  @HiveField(36) final String categoria;
  @HiveField(0) final String nombreCompleto;
  @HiveField(1) final String fechaNacimiento;
  @HiveField(2) final String edad;
  @HiveField(3) final String sexo;
  @HiveField(4) final String nacionalidad;
  @HiveField(5) final String lugarNacimiento;
  @HiveField(6) final String numeroExpediente;
  @HiveField(7) final String fechaIngreso;
  @HiveField(8) final String fechaEgreso;
  @HiveField(9) final String motivoIngreso;

  // Información Familiar y Social
  @HiveField(10) final String nombrePadres;
  @HiveField(11) final String relacionPadres;
  @HiveField(12) final String situacionSocioeconomica;
  @HiveField(13) final String contactoFamiliar;

  // Salud Física y Mental
  @HiveField(14) final String estadoSalud;
  @HiveField(15) final String diagnosticos;
  @HiveField(16) final String medicacion;
  @HiveField(17) final String historialConsumo;
  @HiveField(18) final String diagnosticoPsicologico;
  @HiveField(19) final String seguimientoTerapeutico;

  // Escolarización y Formación
  @HiveField(20) final String nivelEducativo;
  @HiveField(21) final String escolarizacionActual;
  @HiveField(22) final String habilidadesFormativas;
  @HiveField(23) final String participacionTalleres;

  // Conducta y Adaptación
  @HiveField(24) final String comportamientoGeneral;
  @HiveField(25) final String incidentesRelevantes;
  @HiveField(26) final String relacionEquipoEducativo;
  @HiveField(27) final String participacionActividades;

  // Evaluación Psicosocial
  @HiveField(28) final String fortalezasPersonales;
  @HiveField(29) final String areasAMejorar;
  @HiveField(30) final String evolucionTiempo;

  // Medidas Judiciales / Administrativas
  @HiveField(31) final String medidaJudicialVigente;
  @HiveField(32) final String historialJudicial;
  @HiveField(33) final String contactoSistemaJudicial;

  // Observaciones
  @HiveField(34) final String valoracionesEquipo;
  @HiveField(35) final String sugerenciasSeguimiento;

  UserModel({
    
    required this.categoria,
    required this.nombreCompleto,
    required this.fechaNacimiento,
    required this.edad,
    required this.sexo,
    required this.nacionalidad,
    required this.lugarNacimiento,
    required this.numeroExpediente,
    required this.fechaIngreso,
    required this.fechaEgreso,
    required this.motivoIngreso,
    required this.nombrePadres,
    required this.relacionPadres,
    required this.situacionSocioeconomica,
    required this.contactoFamiliar,
    required this.estadoSalud,
    required this.diagnosticos,
    required this.medicacion,
    required this.historialConsumo,
    required this.diagnosticoPsicologico,
    required this.seguimientoTerapeutico,
    required this.nivelEducativo,
    required this.escolarizacionActual,
    required this.habilidadesFormativas,
    required this.participacionTalleres,
    required this.comportamientoGeneral,
    required this.incidentesRelevantes,
    required this.relacionEquipoEducativo,
    required this.participacionActividades,
    required this.fortalezasPersonales,
    required this.areasAMejorar,
    required this.evolucionTiempo,
    required this.medidaJudicialVigente,
    required this.historialJudicial,
    required this.contactoSistemaJudicial,
    required this.valoracionesEquipo,
    required this.sugerenciasSeguimiento,
  });
}
