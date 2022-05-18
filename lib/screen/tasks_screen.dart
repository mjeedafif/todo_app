import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../provider/todo_provider.dart';
//widgets
import '../widget/appBar_widget.dart';
import '../widget/listOfTasks.dart';

class HomePageScreen extends StatelessWidget {
  //final DateTime date;
  //final Function showDateTime;
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final date = Provider.of<ToDoProvider>(context, listen: false).date;
    return SingleChildScrollView(
      child: Consumer<ToDoProvider>(
        builder: (ctx, todo, child) => Column(
          children: [
            //date
            const AppBarWidget(),
            const SizedBox(
              height: 20,
            ),
            //List of items
            FutureBuilder(
              future: Provider.of<ToDoProvider>(context, listen: false)
                  .getItems(todo.date),
              builder: (ctx, snapshot) =>
                  // Consumer<ToDoProvider>(
                  //   builder: (ctx, todo, child) =>
                  todo.tasks.isEmpty
                      ? child!
                      : ListTasks(todo.date, todo.tasks),
              // child: SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.5,
              //   child: const Center(
              //     child: Text('No task. Start add one'),
              //   ),
              // ),
            ),
          ],
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: const Center(
            child: Text('No task. Start add one'),
          ),
        ),
      ),
    );
  }
}
