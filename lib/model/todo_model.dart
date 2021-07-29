import 'package:flutter/widgets.dart';

class TodoModel extends ChangeNotifier {
  List _todos = [];
  List get todo => _todos;

  Future<void> addTodo(String? value) async {
    _todos.add({
      'task': value ?? '',
      'done': false,
    });
    notifyListeners();
  }

  Future<void> deleteTodo({
    required int index,
  }) async {
    _todos.removeAt(index);
    notifyListeners();
  }

  Future<void> updateTodo({
    required int index,
    bool done = true,
  }) async {
    _todos[index]['done'] = done;
    notifyListeners();
  }
}
