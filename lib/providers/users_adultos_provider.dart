import 'package:flutter/material.dart';
import 'package:minor_io/models/user_adulto_model';

class UsersAdultosProvider with ChangeNotifier {
  final List<UserAdultoModel> _usuarios = [];

  List<UserAdultoModel> get usuarios => _usuarios;

  void loadUsers() {
    notifyListeners();
  }

  Future<void> addUser(UserAdultoModel user) async {
    _usuarios.add(user);
    notifyListeners();
  }

  Future<void> deleteUser(int index) async {
    _usuarios.removeAt(index);
    notifyListeners();
  }
}
