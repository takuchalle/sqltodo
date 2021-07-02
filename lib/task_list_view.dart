import 'package:flutter/material.dart';
import 'db.dart';
import 'entities/task.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: DB.instance.taskListStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data!;
          return ListView(
            children: [
              ...list
                  .map(
                    (task) => ListTile(
                      leading: Icon(
                        task.done == 1 ? Icons.done : Icons.dangerous,
                      ),
                      title: Text(task.name),
                      onTap: () async {
                        DB.instance.updateTask(
                            task.copyWith(done: task.done == 0 ? 1 : 0));
                      },
                    ),
                  )
                  .toList(),
            ],
          );
        } else {
          return Center(
            child: Text('no data'),
          );
        }
      },
    );
  }
}
