import 'package:flutter/material.dart';
import 'input_dialog.dart';
import 'db.dart';
import 'entities/task.dart';
import 'task_list_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqltodo',
      home: Scaffold(
        body: TaskListView(),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final text = await showInputDialog(context);
              if (text != null) {
                await DB.instance.addTask(Task(name: text, done: 0));
              }
            },
          ),
        ),
      ),
    );
  }
}
