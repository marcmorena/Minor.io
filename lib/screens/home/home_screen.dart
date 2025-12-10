import 'package:flutter/material.dart';
import 'package:minor_io/providers/theme_provider.dart';
import 'package:minor_io/screens/actividades/actividades_screen.dart';
import 'package:minor_io/screens/auth/login_screen.dart';
import 'package:minor_io/screens/diario/diario_personal_screen.dart';
import 'package:minor_io/screens/evaluaciones/evaluaciones_screen.dart';
import 'package:minor_io/screens/users/user_section_screen.dart';
import 'package:minor_io/screens/educators/educators_section_screen.dart';
import 'package:minor_io/screens/incidencias/incidencias_screen.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String nombreReal;

  const HomeScreen({
    super.key,
    required this.username,
    required this.nombreReal,
  });

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('nombreReal');

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        height: 95,
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return BaseScaffold(
      appBar: AppBar(
        title: Text("Bienvenido, $nombreReal",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
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
        actions: [
          IconButton(
            icon: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: const Icon(Icons.nightlight_round, key: ValueKey('moon')),
              secondChild: const Icon(Icons.wb_sunny, key: ValueKey('sun')),
              crossFadeState: isDark
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionCard(
              context: context,
              icon: Icons.group,
              label: 'Usuarios',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UsersSectionScreen())),
            ),
            _buildSectionCard(
              context: context,
              icon: Icons.school,
              label: 'Educadores',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EducatorsSectionScreen())),
            ),
            _buildSectionCard(
              context: context,
              icon: Icons.event,
              label: 'Actividades',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ActividadesScreen())),
            ),
            _buildSectionCard(
              context: context,
              icon: Icons.report_problem,
              label: 'Incidencias',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IncidenciasScreen())),
            ),
            _buildSectionCard(
              context: context,
              icon: Icons.analytics,
              label: 'Evaluaciones',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EvaluacionesScreen())),
            ),
            _buildSectionCard(
              context: context,
              icon: Icons.book,
              label: 'Diario Personal',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DiarioPersonalScreen(educadorCodigo: username),
                ),
              ),
            ),
          ].map((card) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: card,
          )).toList(),
        ),
      ),
    );
  }
}
