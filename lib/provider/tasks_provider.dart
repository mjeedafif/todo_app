import 'package:flutter/material.dart';
import '../helper/todo_helper.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  final DateTime date;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isComplete = false,
  });

  Future<void> toggleCompleted() async {
    isComplete = !isComplete;
    await ToDoHelper.updateTaskComplete(id, isComplete ? 1 : 0);
    notifyListeners();
  }
}
