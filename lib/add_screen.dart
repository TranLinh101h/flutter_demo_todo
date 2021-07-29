import 'package:demo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new todo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TodoModel>(context, listen: false)
                  .addTodo(_controller.text)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
