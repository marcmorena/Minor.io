import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:minor_io/models/user_menor_model.dart';

class UsersMenoresProvider with ChangeNotifier {
  List<UserMenorModel> _usuarios = [];

  List<UserMenorModel> get usuarios => _usuarios;

  Future<void> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('usuarios_menores');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      _usuarios = jsonList.map((e) => UserMenorModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  Future<void> addUser(UserMenorModel user) async {
    _usuarios.add(user);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'usuarios_menores',
      json.encode(_usuarios.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  Future<void> deleteUser(int index) async {
    _usuarios.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'usuarios_menores',
      json.encode(_usuarios.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  Future<void> clearUsers() async {
    _usuarios.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuarios_menores');
    notifyListeners();
  }
}
