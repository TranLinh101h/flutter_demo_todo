import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoModel extends ChangeNotifier {
  List _todos = [];
  List get todo => _todos;

  Future<void> fetchTodo() async {
    var _pref = await SharedPreferences.getInstance();
    String todos = await _pref.getString('todos') ?? '[]';
    _todos = jsonDecode(todos);
    notifyListeners();
  }

  Future<void> updatePref() async {
    var _pref = await SharedPreferences.getInstance();
    await _pref.setString('todos', jsonEncode(_todos));
  }

  Future<void> addTodo(String? value) async {
    _todos.add({
      'task': value ?? '',
      'done': false,
    });
    await updatePref();
    notifyListeners();
  }

  Future<void> updateTodo({
    required int index,
    bool done = true,
  }) async {
    _todos[index]['done'] = done;
    await updatePref();
    notifyListeners();
  }

  Future<void> deleteTodo({
    required int index,
  }) async {
    _todos.removeAt(index);
    await updatePref();
    notifyListeners();
  }

  Future<void> truncateTodo() async {
    _todos = [];
    await updatePref();
    notifyListeners();
  }
}
