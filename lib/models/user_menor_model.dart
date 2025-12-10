class UserMenorModel {
  // Información General
  final String nombre;
  final String fechaNacimiento;
  final String edad;
  final String sexo;
  final String nacionalidad;
  final String lugarNacimiento;
  final String numExpediente;
  final String fechaIngreso;
  final String fechaEgreso;
  final String motivoIngreso;

  // Información Familiar y Social
  final String nombrePadres;
  final String relacionPadres;
  final String situacionSocioeconomica;
  final String contactoFamiliar;

  // Salud Física y Mental
  final String estadoSalud;
  final String diagnosticos;
  final String medicacion;
  final String historialConsumo;
  final String diagnosticoPsicologico;
  final String seguimientoTerapeutico;

  // Escolarización y Formación
  final String nivelEducativo;
  final String escolarizacionActual;
  final String habilidadesFormativas;
  final String participacionTalleres;

  // Conducta y Adaptación en el Centro
  final String comportamientoGeneral;
  final String incidentesRelevantes;
  final String relacionEquipoEducativo;
  final String participacionActividades;

  // Evaluación Psicosocial
  final String fortalezasPersonales;
  final String areasAMejorar;
  final String evolucionTiempo;

  // Medidas Judiciales / Administrativas
  final String medidaJudicialVigente;
  final String historialJudicial;
  final String contactoSistemaJudicial;

  // Observaciones
  final String valoracionesEquipo;
  final String sugerenciasSeguimiento;

  UserMenorModel({
    required this.nombre,
    required this.fechaNacimiento,
    required this.edad,
    required this.sexo,
    required this.nacionalidad,
    required this.lugarNacimiento,
    required this.numExpediente,
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

  factory UserMenorModel.fromJson(Map<String, dynamic> json) {
    return UserMenorModel(
      nombre: json['nombre'] ?? '',
      fechaNacimiento: json['fechaNacimiento'] ?? '',
      edad: json['edad'] ?? '',
      sexo: json['sexo'] ?? '',
      nacionalidad: json['nacionalidad'] ?? '',
      lugarNacimiento: json['lugarNacimiento'] ?? '',
      numExpediente: json['numExpediente'] ?? '',
      fechaIngreso: json['fechaIngreso'] ?? '',
      fechaEgreso: json['fechaEgreso'] ?? '',
      motivoIngreso: json['motivoIngreso'] ?? '',
      nombrePadres: json['nombrePadres'] ?? '',
      relacionPadres: json['relacionPadres'] ?? '',
      situacionSocioeconomica: json['situacionSocioeconomica'] ?? '',
      contactoFamiliar: json['contactoFamiliar'] ?? '',
      estadoSalud: json['estadoSalud'] ?? '',
      diagnosticos: json['diagnosticos'] ?? '',
      medicacion: json['medicacion'] ?? '',
      historialConsumo: json['historialConsumo'] ?? '',
      diagnosticoPsicologico: json['diagnosticoPsicologico'] ?? '',
      seguimientoTerapeutico: json['seguimientoTerapeutico'] ?? '',
      nivelEducativo: json['nivelEducativo'] ?? '',
      escolarizacionActual: json['escolarizacionActual'] ?? '',
      habilidadesFormativas: json['habilidadesFormativas'] ?? '',
      participacionTalleres: json['participacionTalleres'] ?? '',
      comportamientoGeneral: json['comportamientoGeneral'] ?? '',
      incidentesRelevantes: json['incidentesRelevantes'] ?? '',
      relacionEquipoEducativo: json['relacionEquipoEducativo'] ?? '',
      participacionActividades: json['participacionActividades'] ?? '',
      fortalezasPersonales: json['fortalezasPersonales'] ?? '',
      areasAMejorar: json['areasAMejorar'] ?? '',
      evolucionTiempo: json['evolucionTiempo'] ?? '',
      medidaJudicialVigente: json['medidaJudicialVigente'] ?? '',
      historialJudicial: json['historialJudicial'] ?? '',
      contactoSistemaJudicial: json['contactoSistemaJudicial'] ?? '',
      valoracionesEquipo: json['valoracionesEquipo'] ?? '',
      sugerenciasSeguimiento: json['sugerenciasSeguimiento'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'fechaNacimiento': fechaNacimiento,
      'edad': edad,
      'sexo': sexo,
      'nacionalidad': nacionalidad,
      'lugarNacimiento': lugarNacimiento,
      'numExpediente': numExpediente,
      'fechaIngreso': fechaIngreso,
      'fechaEgreso': fechaEgreso,
      'motivoIngreso': motivoIngreso,
      'nombrePadres': nombrePadres,
      'relacionPadres': relacionPadres,
      'situacionSocioeconomica': situacionSocioeconomica,
      'contactoFamiliar': contactoFamiliar,
      'estadoSalud': estadoSalud,
      'diagnosticos': diagnosticos,
      'medicacion': medicacion,
      'historialConsumo': historialConsumo,
      'diagnosticoPsicologico': diagnosticoPsicologico,
      'seguimientoTerapeutico': seguimientoTerapeutico,
      'nivelEducativo': nivelEducativo,
      'escolarizacionActual': escolarizacionActual,
      'habilidadesFormativas': habilidadesFormativas,
      'participacionTalleres': participacionTalleres,
      'comportamientoGeneral': comportamientoGeneral,
      'incidentesRelevantes': incidentesRelevantes,
      'relacionEquipoEducativo': relacionEquipoEducativo,
      'participacionActividades': participacionActividades,
      'fortalezasPersonales': fortalezasPersonales,
      'areasAMejorar': areasAMejorar,
      'evolucionTiempo': evolucionTiempo,
      'medidaJudicialVigente': medidaJudicialVigente,
      'historialJudicial': historialJudicial,
      'contactoSistemaJudicial': contactoSistemaJudicial,
      'valoracionesEquipo': valoracionesEquipo,
      'sugerenciasSeguimiento': sugerenciasSeguimiento,
    };
  }
}
