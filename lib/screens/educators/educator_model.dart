class EducatorModel {
  final String codigo;
  final String nombreCompleto;
  final String dni;
  final String telefono;
  final String email;
  final String fechaInicioContrato;
  final String fechaFinContrato;

  EducatorModel({
    required this.codigo,
    required this.nombreCompleto,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.fechaInicioContrato,
    required this.fechaFinContrato,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'nombreCompleto': nombreCompleto,
      'dni': dni,
      'telefono': telefono,
      'email': email,
      'fechaInicioContrato': fechaInicioContrato,
      'fechaFinContrato': fechaFinContrato,
    };
  }

  factory EducatorModel.fromJson(Map<String, dynamic> json) {
    return EducatorModel(
      codigo: json['codigo'],
      nombreCompleto: json['nombreCompleto'],
      dni: json['dni'],
      telefono: json['telefono'],
      email: json['email'],
      fechaInicioContrato: json['fechaInicioContrato'],
      fechaFinContrato: json['fechaFinContrato'],
    );
  }
}
