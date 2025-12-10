import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minor_io/models/user_model.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class DeleteUsersScreen extends StatelessWidget {
  final String category;

  const DeleteUsersScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BaseScaffold(
      appBar: AppBar(title: Text("Eliminar Usuarios - $category",
          style: const TextStyle(fontWeight: FontWeight.bold))),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<UserModel>('usuarios').listenable(),
        builder: (context, Box<UserModel> box, _) {
          final usuarios = box.values
              .where((user) => user.categoria.toLowerCase() == category.toLowerCase())
              .toList();

          if (usuarios.isEmpty) {
            return const Center(child: Text("No hay usuarios registrados."));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: usuarios.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return Card(
                color: isDark ? const Color(0xFF2C2C2C) : Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    usuario.nombreCompleto,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Edad: ${usuario.edad} • Sexo: ${usuario.sexo}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmarEliminacion(context, usuario),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, UserModel usuario) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Eliminar usuario?"),
        content: Text("¿Estás seguro de eliminar a ${usuario.nombreCompleto}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await usuario.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario eliminado")),
      );
    }
  }
}
