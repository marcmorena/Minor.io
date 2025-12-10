import 'package:flutter/material.dart';
import 'package:minor_io/providers/educator_provider.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:provider/provider.dart';

class DeleteEducatorsScreen extends StatefulWidget {
  const DeleteEducatorsScreen({super.key});

  @override
  State<DeleteEducatorsScreen> createState() => _DeleteEducatorsScreenState();
}

class _DeleteEducatorsScreenState extends State<DeleteEducatorsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<EducatorsProvider>(context, listen: false).loadEducators());
  }

  Future<void> _confirmDelete(BuildContext context, int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar eliminación"),
        content: const Text("¿Estás seguro de que quieres eliminar este educador?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar",)),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Eliminar", style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      await Provider.of<EducatorsProvider>(context, listen: false)
          .deleteEducator(index);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Educador eliminado")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducatorsProvider>(context);

    return BaseScaffold(
      appBar: AppBar(title: const Text("Eliminar Educadores",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: provider.educators.isEmpty
          ? const Center(child: Text("No hay educadores registrados."))
          : ListView.builder(
      itemCount: provider.educators.length,
      itemBuilder: (context, index) {
        final educator = provider.educators[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              educator.nombreCompleto,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "Código: ${educator.codigo}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(context, index),
            ),
          ),
        );
      },
    ),
    );
  }
}
