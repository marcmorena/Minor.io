import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:minor_io/utils/gravedad_utils.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import '../../models/incidencia.dart';

class NewIncidenciaScreen extends StatefulWidget {
  const NewIncidenciaScreen({super.key});

  @override
  State<NewIncidenciaScreen> createState() => _NewIncidenciaScreenState();
}

class _NewIncidenciaScreenState extends State<NewIncidenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _usuarioSeleccionado;
  String _tipo = 'Leve';
  String _descripcion = '';
  DateTime _fecha = DateTime.now();
  List<String> _nombresUsuarios = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cargarUsuarios();
  }

  void _cargarUsuarios() {
  final box = Hive.box<UserModel>('usuarios');
  final usuarios = box.values.toList();

  final nombres = usuarios.map((u) => u.nombreCompleto).toSet().toList();

  setState(() {
    _nombresUsuarios = nombres;
  });
}


  Future<void> _guardarIncidencia() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final incidencia = Incidencia(
      usuarioNombre: _usuarioSeleccionado!,
      descripcion: _descripcion,
      fecha: _fecha,
      gravedad: gravedadFromString(_tipo),
    );

    final box = Hive.box<Incidencia>('incidencias');
    await box.add(incidencia);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incidencia guardada")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text("Nueva Incidencia",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _nombresUsuarios.isEmpty
            ? const Center(child: Text("No hay usuarios registrados."))
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField<String>(
                    value: _usuarioSeleccionado,
                    decoration: const InputDecoration(
                      labelText: "Usuario",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.white,
                    items: _nombresUsuarios
                        .map((u) => DropdownMenuItem(
                              value: u,
                              child: Text(
                                u,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _usuarioSeleccionado = value),
                    validator: (value) => value == null ? 'Seleccione un usuario' : null,
                  ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _tipo,
                      decoration: const InputDecoration(
                        labelText: "Tipo de incidencia",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      items: ['Leve', 'Moderada', 'Grave']
                          .map(
                            (t) => DropdownMenuItem(
                              value: t,
                              child: Text(
                                t,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() => _tipo = value!),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Fecha",
                        labelStyle: const TextStyle(color: Colors.white),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
                      ),
                      controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(_fecha)),
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _fecha,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => _fecha = picked);
                      },
                    ),

                    const SizedBox(height: 12),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Descripción",
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      maxLines: 4,
                      onSaved: (value) => _descripcion = value ?? '',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Escriba una descripción' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _guardarIncidencia,
                      icon: const Icon(Icons.save),
                      label: const Text("Guardar Incidencia",
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
