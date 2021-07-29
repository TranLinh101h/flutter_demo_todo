import 'package:demo/add_screen.dart';
import 'package:demo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer<TodoModel>(
          builder: (_, data, child) {
            return ListView(
              children: List.generate(data.todo.length, (index) {
                var todo = data.todo[index];
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.done,
                        color: todo['done'] ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        Provider.of<TodoModel>(context, listen: false)
                            .updateTodo(index: index, done: !todo['done']);
                      },
                    ),
                    title: Text(
                      todo['task'],
                      style: todo['done']
                          ? TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<TodoModel>(context, listen: false)
                            .deleteTodo(index: index);
                      },
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
      ),
    );
  }
}
