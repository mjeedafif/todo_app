import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//provider
import '../provider/todo_provider.dart';
import '../provider/tasks_provider.dart';

//Screen
import './profile_screen.dart';
import './tasks_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Main data list of tasks and date
  List<Task> items = [];
  late DateTime
      date; // = Provider.of<ToDoProvider>(context, listen: false).date;
  int initTap = 0;

  @override
  void initState() {
    date = Provider.of<ToDoProvider>(context, listen: false).date;
    super.initState();
  }

  void _changeScreen(int index) {
    setState(() {
      initTap = index;
    });
  }

  // DateTime showDateTime(DateTime value) {
  //   //DateTime? chooseDate;

  //   // DateTime? chooseDate = await showDatePicker(
  //   //   context: context,
  //   //   initialDate: date,
  //   //   firstDate: DateTime(2021, 9, 29),
  //   //   lastDate: DateTime(2022, 12, 1),
  //   // );

  //   //Rebuild when user change the date and get the tasks
  //   setState(() {
  //     items = Provider.of<ToDoProvider>(context, listen: false).tasks;
  //     date = value;
  //   });
  //   return date;
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('Build the widget ..');
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: //Floating of date
          FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => SizedBox(
            height: 350,
            child: Column(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(right: 8.0),
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
                      Provider.of<ToDoProvider>(context, listen: false)
                          .assignDate(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        child: const Icon(Icons.date_range),
        backgroundColor: const Color(0xffBC5BDE),
      ),
      bottomNavigationBar:
          // BottomAppBar(
          //   // Bottom for home and profile
          //   shape: const CircularNotchedRectangle(),
          //   notchMargin: 5,
          //   clipBehavior: Clip.antiAlias,
          //   child:
          BottomNavigationBar(
        onTap: (value) => _changeScreen(value),
        currentIndex: initTap,
        selectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      // ),
      body: initTap == 0
          ? const HomePageScreen()
          //showDateTime)
          : const ProfileScreen(),
    );
  }
}
