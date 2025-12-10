import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import '../../models/actividad.dart';

class NewActividadScreen extends StatefulWidget {
  final String educadorCodigo;
  const NewActividadScreen({super.key, required this.educadorCodigo});

  @override
  State<NewActividadScreen> createState() => _NewActividadScreenState();
}

class _NewActividadScreenState extends State<NewActividadScreen> {
  final _formKey = GlobalKey<FormState>();
  String _titulo = '';
  String _descripcion = '';
  DateTime _fecha = DateTime.now();
  TimeOfDay? _horaInicio;
  TimeOfDay? _horaFin;
  final List<String> _participantes = [];
  List<String> _usuariosDisponibles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cargarUsuarios();
  }

  void _cargarUsuarios() {
  final box = Hive.box<UserModel>('usuarios');
  final usuarios = box.values.toList();

  final nombres = usuarios.map((u) => u.nombreCompleto).toSet().toList(); // Evitar duplicados

  setState(() {
    _usuariosDisponibles = nombres;
  });
}

  Future<void> _guardarActividad() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final horaInicioStr = _horaInicio != null ? _horaInicio!.format(context) : '';
    final horaFinStr = _horaFin != null ? _horaFin!.format(context) : '';

    final contieneHorario = _descripcion.toLowerCase().contains("horario:");

    final nueva = Actividad(
      titulo: _titulo,
      descripcion: _descripcion +
          (!contieneHorario && _horaInicio != null && _horaFin != null
              ? "\nHorario: $horaInicioStr - $horaFinStr"
              : ''),
      fecha: _fecha,
      participantes: _participantes,
      educadorCodigo: widget.educadorCodigo,
      completada: false,
    );

    final box = Hive.box<Actividad>('actividades');
    await box.add(nueva);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Actividad guardada")),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _seleccionarHoraInicio() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() => _horaInicio = picked);
    }
  }

  Future<void> _seleccionarHoraFin() async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() => _horaFin = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('Nueva Actividad',
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) => value == null || value.isEmpty ? 'Ingrese un título' : null,
                onSaved: (value) => _titulo = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                onSaved: (value) => _descripcion = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Fecha",
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(_fecha)),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _fecha,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _fecha = picked);
                  }
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _seleccionarHoraInicio,
                      icon: const Icon(Icons.access_time),
                      label: Text(_horaInicio != null
                          ? "Inicio: ${_horaInicio!.format(context)}"
                          : "Hora de inicio",),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _seleccionarHoraFin,
                      icon: const Icon(Icons.access_time_filled),
                      label: Text(_horaFin != null
                          ? "Fin: ${_horaFin!.format(context)}"
                          : "Hora de fin"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Seleccionar participantes:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
if (_usuariosDisponibles.isEmpty)
  const Text(
    "No hay usuarios registrados",
    style: TextStyle(color: Colors.white),
  ),
..._usuariosDisponibles.map((usuario) {
  return CheckboxListTile(
    title: Text(
      usuario,
      style: const TextStyle(color: Colors.white),
    ),
    value: _participantes.contains(usuario),
    activeColor: Colors.white,
    checkColor: Colors.black,
    onChanged: (bool? selected) {
      setState(() {
        if (selected == true) {
          _participantes.add(usuario);
        } else {
          _participantes.remove(usuario);
        }
      });
    },
  );
}),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _guardarActividad,
                icon: const Icon(Icons.save),
                label: const Text("Guardar Actividad",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 61, 107, 187)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
