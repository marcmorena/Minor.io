import 'package:flutter/material.dart';
import 'package:minor_io/screens/actividades/new_actividad_screen.dart';
import 'package:minor_io/screens/actividades/consult_actividades_screen.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActividadesScreen extends StatelessWidget {
  const ActividadesScreen({super.key});

  Future<String> _obtenerCodigoEducador() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'educador';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _obtenerCodigoEducador(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final codigoEducador = snapshot.data!;

        return BaseScaffold(
          appBar: AppBar(title: const Text("Gestión de Actividades",
              style: TextStyle(fontWeight: FontWeight.bold))),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildCard(
                  context,
                  icon: Icons.add_circle,
                  label: "Nueva Actividad",
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewActividadScreen(educadorCodigo: codigoEducador),
                      ),
                    );
                  },
                ),
                _buildCard(
                  context,
                  icon: Icons.list_alt,
                  label: "Consultar Actividades",
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConsultActividadesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
