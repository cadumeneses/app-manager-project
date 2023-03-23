import 'package:app_manager_project/core/task/models/task_model.dart';
import 'package:app_manager_project/core/task/models/tasks_repository.dart';
import 'package:flutter/material.dart';

class TaskPresenter with ChangeNotifier {
  final TaskRepository _taskRepository;
  bool _isLoading = false;
  String _error = '';

  TaskPresenter(this._taskRepository);

  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> submitForm(String taskName, String projectId) async {
    _isLoading = true;
    _error = '';

    try {
      await _taskRepository
          .save(TaskModel(id: '', name: taskName, projectId: projectId));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
