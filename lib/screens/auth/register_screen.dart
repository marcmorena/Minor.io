import 'package:flutter/material.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreRealController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _nombreUsuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repetirPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: const Text("Registrarse",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Center(
              child: Image.asset(
                'assets/logo_home_screen.png',
                height: 180,
              ),
            ),
            const SizedBox(height: 20),
              _buildRoundedTextField(
                controller: _nombreRealController,
                label: 'Nombre',
              ),
              const SizedBox(height: 16),
              _buildRoundedTextField(
                controller: _apellidosController,
                label: 'Apellidos',
              ),
              const SizedBox(height: 16),
              _buildRoundedTextField(
                controller: _nombreUsuarioController,
                label: 'Nombre de usuario',
              ),
              const SizedBox(height: 16),
              _buildRoundedTextField(
                controller: _passwordController,
                label: 'Contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              _buildRoundedTextField(
                controller: _repetirPasswordController,
                label: 'Repetir contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text == _repetirPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registro exitoso (simulado)")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Las contraseñas no coinciden")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 61, 107, 187),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Crear cuenta",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }
}
