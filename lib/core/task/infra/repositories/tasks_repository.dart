import 'package:app_manager_project/core/task/infra/models/task_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TaskRepository extends ChangeNotifier {
  var dio = Dio();

  final String _token;
  final String _uid;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => [..._tasks];

  int get tasksCount {
    return _tasks.length;
  }

  TaskRepository([
    this._token = '',
    this._uid = '',
    this._tasks = const [],
  ]);

  Future<void> loadTasks(String projectId) async {
    _tasks.clear();

    try {
      final response = await dio.get(
        'https://manager-projects-flutter-default-rtdb.firebaseio.com/projects/$projectId/tasks.json?auth=$_token',
      );
      Map<String, dynamic> data = response.data;

      data.forEach((taskId, taskData) {
        _tasks.add(
          TaskModel(
            id: taskId,
            name: taskData['name'],
            dateInit: taskData['dateInit'],
            projectId: taskData['projectId'],
          ),
        );
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> save(Map<String, dynamic> data) async {
    final task = TaskModel(
      id: Random().nextDouble().toString(),
      name: data['name'],
      dateInit: DateTime.now(),
      projectId: data['projectId'],
    );
    addTask(task);
  }

  Future<void> addTask(TaskModel task) async {

    try {
      final response = await dio.post(
        'https://manager-projects-flutter-default-rtdb.firebaseio.com/tasks.json?auth=$_token',
        data: {
          "name": task.name,
          "dateInit": DateTime.now(),
          "projectId": task.projectId
        },
      );
      final id = response.data['name'];
      _tasks.add(TaskModel(
        id: id,
        name: task.name,
        dateInit: task.dateInit,
        projectId: task.projectId,
      ));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
