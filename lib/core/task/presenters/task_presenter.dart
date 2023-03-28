import 'package:app_manager_project/core/task/models/task_model.dart';
import 'package:app_manager_project/core/task/models/tasks_repository.dart';
import 'package:flutter/material.dart';

class TaskPresenter with ChangeNotifier {
  final TaskRepository _taskRepository;
  bool _isLoading = false;
  String _error = '';
  List<TaskModel> _tasks = [];
  List<TaskModel> _allTasks = [];
  List<TaskModel> get tasks => [..._tasks];
  List<TaskModel> get allTasks => [..._allTasks];

  TaskPresenter(this._taskRepository);

  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> submitForm(String taskName, String projectId) async {
    _isLoading = true;
    _error = '';

    try {
      await _taskRepository.save(
        TaskModel(
          id: '',
          name: taskName,
          projectId: projectId,
        ),
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      loadTasks(projectId);
      notifyListeners();
    }
  }

  Future<void> loadTasks(String projectId) async {
    _isLoading = true;
    _error = '';
    try {
      _tasks = await _taskRepository.loadTasks(projectId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAllTasks() async {
    _isLoading = true;
    _error = '';
    try {
     _allTasks = await _taskRepository.loadAllTasks();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTaskStatus(TaskModel task) async {
    _isLoading = true;
    _error = '';
    try {
      if (task.status == true) {
        return;
      } else {
        task.status == true;
      }
      await _taskRepository.save(task);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
