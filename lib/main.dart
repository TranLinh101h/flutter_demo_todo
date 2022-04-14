import 'package:demo/add_screen.dart';
import 'package:demo/model/todo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'model/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootApp();
}

Future<void> bootApp() async {
  LocaleProvider provider = LocaleProvider();
  await provider.fetchLocale();
  print('---fetchLanguageModel: ${provider.locale.languageCode}---');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TodoModel()),
      ChangeNotifierProvider(
        create: (context) => provider,
      )
    ],
    child: InitApp(),
  ));
}

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Consumer<LocaleProvider>(builder: (_, provider, child) {
      print('---provider: ${provider.langCode}');
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: provider.locale,
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
    });
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
            Text(AppLocalizations.of(context)!.title),
            SizedBox(
              width: 55,
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () async {
                    final provider =
                        Provider.of<LocaleProvider>(context, listen: false);
                    await provider.setLocale('en');
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
                onPressed: () async {
                  final provider =
                      Provider.of<LocaleProvider>(context, listen: false);
                  await provider.setLocale('vi');
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
