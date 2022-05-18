// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//provider
import '../provider/tasks_provider.dart';

//Widgets
import '../widget/task_widget.dart';
import '../widget/add_task.dart';

class ListTasks extends StatelessWidget {
  final DateTime date;
  final List<Task> items;
  // final Function showDateTime;

  // ignore: use_key_in_widget_constructors
  const ListTasks(
    this.date,
    this.items,
    //this.showDateTime,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: items[i],
          child: Consumer<Task>(
            builder: (ctx, task, ch) => GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (ctx) => AddtaskWidget(
                  id: items[i].id,
                  //showDateTime: showDateTime,
                  taskName: items[i].title,
                  isEditing: true,
                  //date: date,
                ),
              ),
              child: TaskWidget(
                date,
                items[i].id,
                items[i].title,
                items[i].isComplete,
              ),
            ),
          ),
        ),
        itemCount: items.length,
      ),
    );
  }
}
