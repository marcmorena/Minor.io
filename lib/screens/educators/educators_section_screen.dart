import 'package:flutter/material.dart';
import 'package:minor_io/screens/educators/add_educator_screen.dart';
import 'package:minor_io/screens/educators/consult_educator_screen.dart';
import 'package:minor_io/screens/educators/delete_educator_screen.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class EducatorsSectionScreen extends StatelessWidget {
  const EducatorsSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'label': 'Consultar educadores',
        'icon': Icons.search,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ConsultEducatorScreen(),
            ),
          );
        }
      },
      {
        'label': 'Añadir educador',
        'icon': Icons.person_add,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEducatorScreen(),
            ),
          );
        }
      },
      {
        'label': 'Borrar educador',
        'icon': Icons.delete,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DeleteEducatorsScreen(),
            ),
          );
        }
      },
    ];

    return BaseScaffold(
      appBar: AppBar(
        title: const Text('Gestión de Educadores',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: actions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final item = actions[index];
            return GestureDetector(
              onTap: item['onTap'],
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Icon(item['icon'], color: Colors.white, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['label'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
