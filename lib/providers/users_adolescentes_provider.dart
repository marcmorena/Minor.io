import 'package:flutter/material.dart';
import 'package:minor_io/models/user_adolescente_model';

class UsersAdolescentesProvider with ChangeNotifier {
  final List<UserAdolescenteModel> _usuarios = [];

  List<UserAdolescenteModel> get usuarios => _usuarios;

  void loadUsers() {
    notifyListeners();
  }

  Future<void> addUser(UserAdolescenteModel user) async {
    _usuarios.add(user);
    notifyListeners();
  }

  Future<void> deleteUser(int index) async {
    _usuarios.removeAt(index);
    notifyListeners();
  }
}
