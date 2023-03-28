import 'package:app_manager_project/core/external/dio/dio_client.dart';
import 'package:app_manager_project/core/task/models/task_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class TaskRepository {
  var dio = DioClient();

  final String _token;
  final String _uid;

  List<TaskModel> _tasks = [];
  List<TaskModel> _allTasks = [];

  int get tasksCount {
    return _tasks.length;
  }

  TaskRepository([
    this._token = '',
    this._uid = '',
    this._tasks = const [],
  ]);

  Future<List<TaskModel>> loadTasks(String projectId) async {
    try {
      final response = await dio.dio.get(
        'https://taskforce-47f99-default-rtdb.firebaseio.com/tasks.json?auth=$_token',
      );
      Map<String, dynamic> data = response.data;
      List<TaskModel> newTasks = [];

      if (data.isEmpty) {
        _tasks = [];
      }

      data.forEach((taskId, taskData) {
        if (taskData['projectId'] == projectId) {
          try {
            TaskModel task = TaskModel(
              id: taskId,
              name: taskData['name'],
              dateInit: taskData['dateInit'],
              projectId: taskData['projectId'],
            );
            newTasks.add(task);
          } catch (e) {
            rethrow;
          }
          if (!listEquals(_tasks, newTasks)) {
            _tasks = newTasks;
          }
        }
      });

      return _tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> loadAllTasks() async {
    try {
      final response = await dio.dio.get(
        'https://taskforce-47f99-default-rtdb.firebaseio.com/tasks.json?auth=$_token',
      );
      Map<String, dynamic> data = response.data;
      List<TaskModel> newTasks = [];

      if (data.isEmpty) {
        _allTasks = [];
      }

      data.forEach((taskId, taskData) {
        try {
          TaskModel task = TaskModel(
            id: taskId,
            name: taskData['name'],
            dateInit: taskData['dateInit'],
            projectId: taskData['projectId'],
          );
          newTasks.add(task);
        } catch (e) {
          rethrow;
        }
        if (!listEquals(_allTasks, newTasks)) {
          _allTasks = newTasks;
        }
      });

      return _allTasks;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> save(TaskModel data) async {
    bool hasId = data.id.isNotEmpty;
    final task = TaskModel(
      id: hasId ? data.id : Random().nextDouble().toString(),
      name: data.name,
      projectId: data.projectId,
      status: data.status,
    );
    if (hasId) {
      updateTask(task);
    } else {
      await addTask(task);
    }
  }

  Future<void> addTask(TaskModel task) async {
    final date = DateTime.now();
    final response = await dio.dio.post(
      'https://taskforce-47f99-default-rtdb.firebaseio.com/tasks.json?auth=$_token',
      data: {
        "name": task.name,
        "dateInit": date.toIso8601String(),
        "projectId": task.projectId,
        "status": task.status,
      },
    );
    final id = response.data['name'];
    _tasks.add(
      TaskModel(
        id: id,
        name: task.name,
        dateInit: task.dateInit,
        projectId: task.projectId,
        status: task.status,
      ),
    );
  }

  Future<void> updateTask(TaskModel task) async {
    int index = _tasks.indexWhere((element) => element.id == task.id);

    if (index >= 0) {
      await dio.dio.patch(
        'https://taskforce-47f99-default-rtdb.firebaseio.com/tasks.id.json?auth=$_token',
        data: {
          "name": task.name,
          "dateInit": task.dateInit,
          "status": task.status,
        },
      );
      _tasks[index] = task;
    }
  }
}
