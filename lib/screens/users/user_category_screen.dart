import 'package:flutter/material.dart';
import 'package:minor_io/screens/users/add_user_screen.dart';
import 'package:minor_io/screens/users/consult_user_screen.dart';
import 'package:minor_io/screens/users/delete_user_screen.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class UserCategoryScreen extends StatelessWidget {
  final String category;

  const UserCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'label': 'Consultar usuarios',
        'icon': Icons.search,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConsultUsersScreen(category: category),
            ),
          );
        }
      },
      {
        'label': 'Añadir usuario',
        'icon': Icons.person_add,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddUserScreen(category: category),
            ),
          );
        }
      },
      {
        'label': 'Borrar usuario',
        'icon': Icons.delete,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DeleteUsersScreen(category: category),
            ),
          );
        }
      },
    ];

    return BaseScaffold(
      appBar: AppBar(
        title: Text('Categoría: $category',
            style: const TextStyle(fontWeight: FontWeight.bold)),
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
