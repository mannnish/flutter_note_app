import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/db/db_helper.dart';
import 'package:flutter_note_app/core/models/tasks_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final taskList = [].obs;

  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  Future<void> addTask({@required Task task}) async {
    await DBHelper.insertTask(task);
    getTasks();
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> task = await DBHelper.queryTask();
    taskList.assignAll(task.map((data) => Task.fromJson(data)).toList());
  }

  Future<void> deleteTask({@required Task task}) async {
    await DBHelper.deleteTask(task);
    getTasks();
  }

  Future<void> updateTask({@required Task task}) async {
    await DBHelper.updateTask(task);
    getTasks();
  }
}
