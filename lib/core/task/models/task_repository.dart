import 'package:app_manager_project/core/external/dio/dio_client.dart';
import 'package:app_manager_project/core/task/models/task_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

class TaskRepository {
  final _client = DioClient();

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
      final response = await _client.dio.get(
        'tasks.json?auth=$_token',
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
            throw Exception('Erro ao analisar os dados da tarefa: $e');
          }
          if (!listEquals(_tasks, newTasks)) {
            _tasks = newTasks;
          }
        }
      });

      return _tasks;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Erro ao carregar as tarefas: ${e.response!.statusCode}');
      } else {
        throw Exception('Erro de rede ao carregar as tarefas: $e');
      }
    } catch (e) {
      throw Exception('Erro ao carregar as tarefas: $e');
    }
  }

  Future<List<TaskModel>> loadAllTasks() async {
    try {
      final response = await _client.dio.get(
        'tasks.json?auth=$_token',
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
          throw Exception('Erro ao analisar os dados da tarefa: $e');
        }
        if (!listEquals(_allTasks, newTasks)) {
          _allTasks = newTasks;
        }
      });

      return _allTasks;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Erro ao carregar as tarefas: ${e.response!.statusCode}');
      } else {
        throw Exception('Erro de rede ao carregar as tarefas: $e');
      }
    } catch (e) {
      throw Exception('Erro ao carregar as tarefas: $e');
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
    final response = await _client.dio.post(
      'tasks.json?auth=$_token',
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
      await _client.dio.patch(
        'tasks.id.json?auth=$_token',
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
