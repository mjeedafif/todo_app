import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../provider/tasks_provider.dart';
import '../provider/todo_provider.dart';

class TaskWidget extends StatelessWidget {
  final String id;
  final String title;
  final bool isComplete;
  final DateTime date;
  const TaskWidget(this.date, this.id, this.title, this.isComplete, {Key? key})
      : super(key: key);

  void checked(BuildContext context) {
    Provider.of<Task>(context, listen: false).toggleCompleted();
  }

  Future<bool?> _confirmDeletion(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure ?'),
        content: const Text('You are going to delete the task'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (_) {
        Provider.of<ToDoProvider>(context, listen: false).deleteTask(id);
      },
      confirmDismiss: (_) => _confirmDeletion(context),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          leading: Checkbox(
            value: isComplete,
            onChanged: (_) => checked(context),
            shape: const CircleBorder(),
          ),
          title: Text(
            title,
            style: TextStyle(
              decoration:
                  isComplete ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
