import 'package:demo/add_screen.dart';
import 'package:demo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/locale_provider.dart';

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
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
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
  void initState() {
    super.initState();
    Provider.of<TodoModel>(context, listen: false).fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.title),
            SizedBox(
              width: 55,
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    // final provider =
                    //     Provider.of<LocaleProvider>(context, listen: false);
                    // provider.setLocale(Locale('en'));
                  },
                  child: Text(
                    'EN',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )),
            ),
            SizedBox(
              width: 55,
              child: FlatButton(
                color: Colors.yellow,
                onPressed: () {
                  // final provider =
                  //     Provider.of<LocaleProvider>(context, listen: false);
                  // provider.setLocale(Locale('vi'));
                },
                child: Text(
                  "VI",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            )
          ],
        ),
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
