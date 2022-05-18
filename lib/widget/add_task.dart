import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//provider
import '../provider/todo_provider.dart';

class AddtaskWidget extends StatefulWidget {
  //final DateTime date;
  final bool isEditing;
  final String? taskName;
  final String? id;
  //final Function(DateTime value) showDateTime;
  const AddtaskWidget({
    this.id,
    this.taskName,
    //required this.showDateTime,
    required this.isEditing,
    //required this.date,
    Key? key,
  }) : super(key: key);

  @override
  State<AddtaskWidget> createState() => _AddtaskWidgetState();
}

class _AddtaskWidgetState extends State<AddtaskWidget> {
  TextEditingController? _task;
  //DateTime? dateTime;
  final GlobalKey<FormState> _form = GlobalKey();
  String initTask = '';

  @override
  void initState() {
    //dateTime = Provider.of<ToDoProvider>(context, listen: false).date;
    _task = TextEditingController(text: initTask);
    if (widget.isEditing) {
      initTask = widget.taskName!;
      _task = TextEditingController(text: initTask);
    }
    super.initState();
  }

  @override
  void dispose() {
    _task!.dispose();
    super.dispose();
  }

  void showSnakBar(String whichAction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task $whichAction successfully',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<ToDoProvider>(
          builder: (ctx, todo, _) => Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Add task',
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: initTask,
                      onChanged: (value) => _task!.text = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Task cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Task'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            // onPressed: () async {
                            //   dateTime = await widget.showDateTime(widget.date);
                            //   setState(() {});
                            // },
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (ctx) => SizedBox(
                                  height: 350,
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: const Text(
                                            'Done',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 280,
                                        child: CupertinoDatePicker(
                                          minimumDate: DateTime(2022, 1, 1),
                                          maximumDate: DateTime(2022, 12, 30),
                                          minimumYear: 2022,
                                          maximumYear: 2022,
                                          initialDateTime: DateTime.now(),
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (value) {
                                            Provider.of<ToDoProvider>(context,
                                                    listen: false)
                                                .assignDate(value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Text('Show Date'),
                          ),
                          Text(DateFormat.yMMMd().format(todo.date)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Row(
              //   children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool isValidate = _form.currentState!.validate();
                    if (isValidate) {
                      // Provider.of<ToDoProvider>(context, listen: false)
                      if (widget.isEditing) {
                        await Provider.of<ToDoProvider>(context, listen: false)
                            .updateTask(
                          todo.date,
                          _task!.text,
                          widget.id!,
                        );
                        showSnakBar('updated');
                      } else {
                        await Provider.of<ToDoProvider>(context, listen: false)
                            .addItem(todo.date, _task!.text);

                        showSnakBar('added');
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(widget.isEditing ? 'Update' : 'Add'),
                ),
              ),
              // TextButton(
              //   onPressed: () async =>
              //       await Provider.of<ToDoProvider>(context, listen: false)
              //           .dropDatabase(),
              //   child: const Text('Drop database'),
              // ),
            ],
            // ),
            // ],
          ),
        ),
      ),
    );
  }
}
