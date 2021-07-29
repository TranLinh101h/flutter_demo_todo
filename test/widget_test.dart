import 'package:demo/main.dart';
import 'package:demo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Todo test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TodoModel()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
          navigatorObservers: [mockObserver],
        ),
      ),
    );
    final BuildContext context = tester.element(find.byType(MyHomePage));
    // Verify that add button appear
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Tap the '+' icon and trigger open new route.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pumpAndSettle();
    // TODO: Test Page Navigation

    // Simulate adding new todo
    // and wait for the result
    Provider.of<TodoModel>(context, listen: false)
        .addTodo('New todo from test');
    await tester.pumpAndSettle();
    expect(find.text('New todo from test'), findsOneWidget);

    // Test on delete previous todo
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();
    expect(find.text('New todo from test'), findsNothing);
  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
