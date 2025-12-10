import 'package:flutter/material.dart';
import 'package:minor_io/screens/users/user_category_screen.dart';
import 'package:minor_io/widgets/base_scaffold.dart';

class UsersSectionScreen extends StatelessWidget {
  const UsersSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ['Menores', 'Adolescentes', 'Adultos'];

    return BaseScaffold(
      appBar: AppBar(
        title: const Text('Categorías de Usuarios',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Color.fromARGB(255, 92, 147, 255),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserCategoryScreen(
                      category: categories[index],
                    ),
                  ),
                );
              },
              child: Text(
                categories[index],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
