import 'package:app_manager_project/features/project/models/project_model.dart';
import 'package:flutter/material.dart';

import '../models/project_repository.dart';

class ProjectPresenter with ChangeNotifier {
  final ProjectRepository _projectRepository;
  bool _isLoading = false;
  String _error = '';

  ProjectPresenter(this._projectRepository);

  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;

  bool get isLoading => _isLoading;
  String get error => _error;

  setArguments(dynamic arguments) {}

  Future<void> submitForm(
    String projectName,
    String projectDescription,
  ) async {
    _isLoading = true;
    _error = '';

    try {
      await _projectRepository.saveProject({
        'name': projectName,
        'description': projectDescription,
      });
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProjects() async {
    _isLoading = true;
    _error = '';

    try {
      _projects = await _projectRepository.loadProjects();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProject(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = '';
    try {
      await _projectRepository.saveProject(data);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
