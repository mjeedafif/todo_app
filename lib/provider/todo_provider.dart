import 'package:flutter/material.dart';

//models
import './tasks_provider.dart';
//Helper
import '../helper/todo_helper.dart';

class ToDoProvider with ChangeNotifier {
  List<Task> _items = [];
  DateTime _date = DateTime.now();

  DateTime get date => _date;

  void assignDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  List<Task> get tasks => _items;

  // Future<List<Task>>
  Future<void> getItems(DateTime? date) async {
    List<Task> _loadedData = [];
    //Logic of getting the data by the checking the date
    _loadedData = await ToDoHelper.getTask();
    _items = _loadedData.where((element) {
      final year = element.date.year;
      final month = element.date.month;
      final day = element.date.day;
      if (year == date!.year && month == date.month && day == date.day) {
        return true;
      } else {
        return false;
      }
    }).toList();
    notifyListeners();
  }

  Future<void> addItem(DateTime date, String title) async {
    //The task object
    final newTask =
        Task(id: DateTime.now().toString(), title: title, date: date);
    //add the object in the list
    _items.add(newTask);
    await ToDoHelper.addTask(newTask);
    notifyListeners();
  }

  Future<void> updateTask(DateTime date, String task, String id) async {
    //Get the index to updated
    final int index = _items.indexWhere((element) => element.id == id);
    //Create the object
    final updatedTask =
        Task(id: DateTime.now().toString(), title: task, date: date);
    //Make the change in the list
    _items[index] = updatedTask;
    await ToDoHelper.updateTaskTitle(id, task);
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    _items.removeWhere((element) => element.id == id);
    await ToDoHelper.deleteTask(id);
    notifyListeners();
  }

  Future dropDatabase() async {
    await ToDoHelper.dropDatabase();
  }
}
