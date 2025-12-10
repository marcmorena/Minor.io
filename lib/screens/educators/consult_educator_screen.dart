import 'package:flutter/material.dart';
import 'package:minor_io/providers/educator_provider.dart';
import 'package:minor_io/widgets/base_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:minor_io/screens/educators/educator_model.dart';

class ConsultEducatorScreen extends StatefulWidget {
  const ConsultEducatorScreen({super.key});

  @override
  State<ConsultEducatorScreen> createState() => _ConsultEducatorsScreenState();
}

class _ConsultEducatorsScreenState extends State<ConsultEducatorScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<EducatorsProvider>(context, listen: false).loadEducators());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EducatorsProvider>(context);

    return BaseScaffold(
      appBar: AppBar(title: const Text("Consultar Educadores",
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: provider.educators.isEmpty
          ? const Center(child: Text("No hay educadores registrados."))
          : ListView.builder(
              itemCount: provider.educators.length,
              itemBuilder: (context, index) {
                final EducatorModel educator = provider.educators[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(
                      educator.nombreCompleto,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Código: ${educator.codigo}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                            "Detalles del Educador",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Código: ${educator.codigo}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text("Nombre: ${educator.nombreCompleto}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text("DNI: ${educator.dni}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text("Teléfono: ${educator.telefono}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text("Email: ${educator.email}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text("Inicio contrato: ${educator.fechaInicioContrato}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text("Fin contrato: ${educator.fechaFinContrato}",
                                    style: Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cerrar",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
