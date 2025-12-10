import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minor_io/providers/educator_provider.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:minor_io/screens/educators/educator_model.dart';

class AddEducatorScreen extends StatefulWidget {
  const AddEducatorScreen({super.key});

  @override
  State<AddEducatorScreen> createState() => _AddEducatorScreenState();
}

class _AddEducatorScreenState extends State<AddEducatorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController codigoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController inicioContratoController = TextEditingController();
  final TextEditingController finContratoController = TextEditingController();

  Future<void> _guardarEducador() async {
  if (!_formKey.currentState!.validate()) return;

  final newEducator = EducatorModel(
    codigo: codigoController.text,
    nombreCompleto: nombreController.text,
    dni: dniController.text,
    telefono: telefonoController.text,
    email: emailController.text,
    fechaInicioContrato: inicioContratoController.text,
    fechaFinContrato: finContratoController.text,
  );

  await Provider.of<EducatorsProvider>(context, listen: false).addEducator(newEducator);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Educador guardado con éxito")),
  );

  Navigator.pop(context);
}


  Future<void> _seleccionarFecha(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.day.toString().padLeft(2, '0')}/"
                        "${picked.month.toString().padLeft(2, '0')}/"
                        "${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text("Añadir Educador",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: codigoController,
                decoration: const InputDecoration(
                  labelText: "Código de educador",
                  labelStyle: TextStyle(color: Colors.white),
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Requerido";
                  }
                  if (value.length < 4) {
                    return "Debe tener 4 cifras";
                  }
                  final exists = Provider.of<EducatorsProvider>(context, listen: false)
                      .educators
                      .any((e) => e.codigo == value);
                  if (exists) {
                    return "Este código ya existe";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre completo",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) => value == null || value.isEmpty ? "Requerido" : null,
              ),

              TextFormField(
                controller: dniController,
                decoration: const InputDecoration(
                  labelText: "DNI",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextFormField(
                controller: telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Teléfono",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              TextFormField( 
                controller: inicioContratoController,
                readOnly: true,
                onTap: () => _seleccionarFecha(inicioContratoController),
                decoration: const InputDecoration(
                  labelText: "Fecha inicio contrato",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              TextFormField(
                controller: finContratoController,
                readOnly: true,
                onTap: () => _seleccionarFecha(finContratoController),
                decoration: const InputDecoration(
                  labelText: "Fecha fin contrato",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarEducador,
                child: const Text("Guardar",
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
