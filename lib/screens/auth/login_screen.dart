import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minor_io/models/educador_login.dart';
import 'package:minor_io/providers/theme_provider.dart';
import 'package:minor_io/screens/auth/register_screen.dart';
import 'package:minor_io/screens/home/home_screen.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nombreController = TextEditingController();
  final _passwordController = TextEditingController();

  void _iniciarSesion() async {
  final nombre = _nombreController.text.trim();
  final password = _passwordController.text;

  final box = Hive.box<EducadorLogin>('educadores_login');

  EducadorLogin? usuario;
  try {
    usuario = box.values.firstWhere(
      (e) => e.nombre == nombre && e.password == password,
    );
  } catch (_) {
    usuario = null;
  }

  if (usuario != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nombre);
    await prefs.setString('nombreReal', usuario.nombreReal);

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          username: nombre,
          nombreReal: usuario!.nombreReal,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nombre o contraseña incorrectos')),
    );
  }
}




  void _irARegistro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
Widget build(BuildContext context) {
  final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

  return BaseScaffold(
    appBar: AppBar(
      title: const Text('Iniciar sesión',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Color(0xFF2D4B73), Color(0xFF1C314F)]
                : [Color(0xFF3B5BA9), Color(0xFF9DB6E3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/logo_home_screen.png',
                height: 250,
              ),
            ),
            
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _nombreController,
                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Nombre de usuario',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Contraseña',
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _iniciarSesion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 61, 107, 187),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
          TextButton(
            onPressed: _irARegistro,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text('¿No tienes cuenta? Regístrate aquí'),
          ),
        ],
      ),
    ),
  );
}
}
