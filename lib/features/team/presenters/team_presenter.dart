import 'package:app_manager_project/features/team/models/team_model.dart';
import 'package:app_manager_project/features/team/models/team_repository.dart';
import 'package:flutter/material.dart';

class TeamPresenter with ChangeNotifier {
  final TeamRepository _teamRepository;
  bool _isLoading = false;
  String _error = '';
  List<TeamModel> _teams = [];
  List<TeamModel> get teams => [..._teams];

  TeamPresenter(this._teamRepository);

  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadTeams(String projectId) async {
    _isLoading = true;
    _error = '';
    try {
      _teams = await _teamRepository.loadBoards(projectId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveBoard(
      String teamName, String projectId) async {
    _isLoading = true;
    _error = '';
    try {
      await _teamRepository.saveTeam(
        TeamModel(
          teamId: '',
          teamName: teamName,
          projectId: projectId,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      loadTeams(projectId);
      notifyListeners();
    }
  }
}