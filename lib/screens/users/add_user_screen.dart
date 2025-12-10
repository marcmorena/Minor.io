import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class AddUserScreen extends StatefulWidget {
  final String category;

  const AddUserScreen({super.key, required this.category});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};
  final _dateFields = ['fechaNacimiento', 'fechaIngreso', 'fechaEgreso'];
  final _dropdownFields = {
    'sexo': ['Hombre', 'Mujer'],
    'relacionPadres': ['Buena', 'Regular', 'Mala', 'Nula'],
    'situacionSocioeconomica': ['Alta', 'Media', 'Baja', 'Muy baja'],
    'contactoFamiliar': ['Frecuente', 'Ocasional', 'Escaso', 'Nulo'],
    'estadoSalud': ['Buena', 'Regular', 'Mala', 'Desconocida'],
    'historialConsumo': ['Nulo', 'Poco', 'Moderado', 'Alto'],
    'nivelEducativo': ['Primaria', 'Secundaria', 'Bachillerato', 'Otros'],
    'escolarizacionActual': ['Sí', 'No', 'Parcial', 'Desconocido'],
    'participacionTalleres': ['Alta', 'Media', 'Baja', 'Nula'],
    'comportamientoGeneral': ['Excelente', 'Bueno', 'Regular', 'Malo'],
    'relacionEquipoEducativo': ['Muy buena', 'Buena', 'Regular', 'Mala'],
    'participacionActividades': ['Alta', 'Media', 'Baja', 'Nula'],
    'evolucionTiempo': ['Muy buena', 'Buena', 'Regular', 'Mala'],
    'medidaJudicialVigente': ['Sí', 'No', 'Parcial', 'Desconocido'],
    'historialJudicial': ['Limpio', 'Leve', 'Moderado', 'Grave'],
    'contactoSistemaJudicial': ['Sí', 'No', 'Ocasional', 'Frecuente'],
  };

  final campos = {
    'Información Personal': {
      'nombreCompleto': 'Nombre completo',
      'fechaNacimiento': 'Fecha de nacimiento',
      'edad': 'Edad',
      'sexo': 'Sexo',
      'nacionalidad': 'Nacionalidad',
      'lugarNacimiento': 'Lugar de nacimiento',
      'numeroExpediente': 'Número de expediente',
      'fechaIngreso': 'Fecha de ingreso',
      'fechaEgreso': 'Fecha de egreso',
      'motivoIngreso': 'Motivo de ingreso',
    },
    'Familia y Entorno': {
      'nombrePadres': 'Nombre de los padres',
      'relacionPadres': 'Relación con los padres',
      'situacionSocioeconomica': 'Situación socioeconómica',
      'contactoFamiliar': 'Contacto familiar',
    },
    'Salud': {
      'estadoSalud': 'Estado de salud',
      'diagnosticos': 'Diagnósticos',
      'medicacion': 'Medicación',
      'historialConsumo': 'Historial de consumo',
      'diagnosticoPsicologico': 'Diagnóstico psicológico',
      'seguimientoTerapeutico': 'Seguimiento terapéutico',
    },
    'Educación': {
      'nivelEducativo': 'Nivel educativo',
      'escolarizacionActual': 'Escolarización actual',
      'habilidadesFormativas': 'Habilidades formativas',
      'participacionTalleres': 'Participación en talleres',
    },
    'Conducta': {
      'comportamientoGeneral': 'Comportamiento general',
      'incidentesRelevantes': 'Incidentes relevantes',
      'relacionEquipoEducativo': 'Relación con equipo educativo',
      'participacionActividades': 'Participación en actividades',
    },
    'Evaluación Psicosocial': {
      'fortalezasPersonales': 'Fortalezas personales',
      'areasAMejorar': 'Áreas a mejorar',
      'evolucionTiempo': 'Evolución en el tiempo',
    },
    'Medidas Judiciales': {
      'medidaJudicialVigente': 'Medida judicial vigente',
      'historialJudicial': 'Historial judicial',
      'contactoSistemaJudicial': 'Contacto con sistema judicial',
    },
    'Observaciones': {
      'valoracionesEquipo': 'Valoraciones del equipo',
      'sugerenciasSeguimiento': 'Sugerencias de seguimiento',
    },
  };

  @override
  void initState() {
    super.initState();
    for (var seccion in campos.values) {
      for (var campo in seccion.keys) {
        controllers[campo] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(String field) async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
      initialDate: now,
    );
    if (result != null) {
      setState(() {
        controllers[field]!.text = DateFormat('yyyy-MM-dd').format(result);
      });
    }
  }

  void _guardarUsuario() {
    final box = Hive.box<UserModel>('usuarios');
    final usuario = UserModel(
      categoria: widget.category,
      nombreCompleto: controllers['nombreCompleto']!.text,
      fechaNacimiento: controllers['fechaNacimiento']!.text,
      edad: controllers['edad']!.text,
      sexo: controllers['sexo']!.text,
      nacionalidad: controllers['nacionalidad']!.text,
      lugarNacimiento: controllers['lugarNacimiento']!.text,
      numeroExpediente: controllers['numeroExpediente']!.text,
      fechaIngreso: controllers['fechaIngreso']!.text,
      fechaEgreso: controllers['fechaEgreso']!.text,
      motivoIngreso: controllers['motivoIngreso']!.text,
      nombrePadres: controllers['nombrePadres']!.text,
      relacionPadres: controllers['relacionPadres']!.text,
      situacionSocioeconomica: controllers['situacionSocioeconomica']!.text,
      contactoFamiliar: controllers['contactoFamiliar']!.text,
      estadoSalud: controllers['estadoSalud']!.text,
      diagnosticos: controllers['diagnosticos']!.text,
      medicacion: controllers['medicacion']!.text,
      historialConsumo: controllers['historialConsumo']!.text,
      diagnosticoPsicologico: controllers['diagnosticoPsicologico']!.text,
      seguimientoTerapeutico: controllers['seguimientoTerapeutico']!.text,
      nivelEducativo: controllers['nivelEducativo']!.text,
      escolarizacionActual: controllers['escolarizacionActual']!.text,
      habilidadesFormativas: controllers['habilidadesFormativas']!.text,
      participacionTalleres: controllers['participacionTalleres']!.text,
      comportamientoGeneral: controllers['comportamientoGeneral']!.text,
      incidentesRelevantes: controllers['incidentesRelevantes']!.text,
      relacionEquipoEducativo: controllers['relacionEquipoEducativo']!.text,
      participacionActividades: controllers['participacionActividades']!.text,
      fortalezasPersonales: controllers['fortalezasPersonales']!.text,
      areasAMejorar: controllers['areasAMejorar']!.text,
      evolucionTiempo: controllers['evolucionTiempo']!.text,
      medidaJudicialVigente: controllers['medidaJudicialVigente']!.text,
      historialJudicial: controllers['historialJudicial']!.text,
      contactoSistemaJudicial: controllers['contactoSistemaJudicial']!.text,
      valoracionesEquipo: controllers['valoracionesEquipo']!.text,
      sugerenciasSeguimiento: controllers['sugerenciasSeguimiento']!.text,
    );
    box.add(usuario);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Usuario guardado exitosamente")),
    );
    Navigator.pop(context);
  }

  Widget _buildField(String key, String label) {
    final inputDecoration = InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
    );

    if (_dateFields.contains(key)) {
      return TextFormField(
        controller: controllers[key],
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        decoration: inputDecoration.copyWith(
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
        ),
        onTap: () => _pickDate(key),
      );
    } else if (_dropdownFields.containsKey(key)) {
      return DropdownButtonFormField<String>(
        value: controllers[key]!.text.isEmpty ? null : controllers[key]!.text,
        decoration: inputDecoration,
        dropdownColor: Colors.black,
        iconEnabledColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        items: _dropdownFields[key]!
            .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) => setState(() => controllers[key]!.text = value!),
      );

    } else {
      return TextFormField(
        controller: controllers[key],
        style: const TextStyle(color: Colors.white),
        decoration: inputDecoration,
        keyboardType: key == 'numeroExpediente'
            ? TextInputType.number
            : TextInputType.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text("Añadir Usuario",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (var entry in campos.entries) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(entry.key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                for (var campo in entry.value.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _buildField(campo.key, campo.value),
                  ),
              ],
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _guardarUsuario,
                icon: const Icon(Icons.save),
                label: const Text("Guardar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 61, 107, 187))
              )
            ],
          ),
        ),
      ),
    );
  }
}
