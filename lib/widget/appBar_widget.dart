// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//provider
import '../provider/todo_provider.dart';

//widgets
import './add_task.dart';

class AppBarWidget extends StatelessWidget {
  //final DateTime date;
  //final Function showDateTime;

  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final date = Provider.of<ToDoProvider>(context, listen: false).date;
    return Container(
      padding: const EdgeInsets.fromLTRB(38, 60, 38, 21),
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Color(0xffBC5BDE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "What to do",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    context: context,
                    builder: (ctx) => const AddtaskWidget(
                      isEditing: false,
                      //date: date,
                      //showDateTime: showDateTime,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          const Divider(
            color: Color(0xffC7C4C4),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              child: Consumer<ToDoProvider>(
                builder: (ctx, todo, _) => Text(
                  DateFormat.yMMMMEEEEd().format(todo.date).toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xffffffff),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
