import 'package:flutter/material.dart';
import 'package:minor_io/screens/educators/educator_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EducatorsProvider with ChangeNotifier {
  List<EducatorModel> _educators = [];

  // Getter para acceder a la lista de educadores
  List<EducatorModel> get educators => _educators;

  // Cargar educadores desde SharedPreferences
  Future<void> loadEducators() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('educadores');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      _educators = jsonList.map((e) => EducatorModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  // Añadir un nuevo educador
  Future<void> addEducator(EducatorModel educator) async {
    _educators.add(educator);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('educadores', json.encode(_educators.map((e) => e.toJson()).toList()));
    notifyListeners();
  }

  // Eliminar un educador por índice
  Future<void> deleteEducator(int index) async {
    _educators.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('educadores', json.encode(_educators.map((e) => e.toJson()).toList()));
    notifyListeners();
  }

  // Borrar toda la lista de educadores (opcional)
  Future<void> clearEducators() async {
    _educators.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('educadores');
    notifyListeners();
  }
}

