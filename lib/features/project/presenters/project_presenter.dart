import 'package:flutter/material.dart';

import '../models/project_repository.dart';

class ProjectPresenter with ChangeNotifier {
  final ProjectRepository _projectRepository;
  bool _isLoading = false;
  String _error = '';

  ProjectPresenter(this._projectRepository);

  bool get isLoading => _isLoading;

  String get error => _error;

  setArguments(dynamic arguments){

  }

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
}
