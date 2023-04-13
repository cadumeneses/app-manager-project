import 'dart:math';

import 'package:app_manager_project/features/team/models/team_model.dart';
import 'package:flutter/foundation.dart';

import '../../../core/external/dio/dio_client.dart';

class TeamRepository {
  var dio = DioClient();

  final String _token;
  final String _uid;

  List<TeamModel> _teams;
  List<TeamModel> get teams => [..._teams];

  TeamRepository([
    this._token = '',
    this._uid = '',
    this._teams = const [],
  ]);

  Future<List<TeamModel>> loadBoards(String projectId) async {
    try {
      final response = await dio.dio.get(
        'teams.json?auth=$_token',
      );

      if (response.data == null) {
        return [];
      }

      Map<String, dynamic> data = response.data;
      List<TeamModel> newTasks = [];

      if (data.isEmpty) {
        _teams = [];
      }

      data.forEach((boardId, boardData) {
        if (boardData['projectId'] == projectId) {
          try {
            TeamModel board = TeamModel(
              teamId: boardId,
              teamName: boardData['name'],
              projectId: boardData['projectId'],
            );
            newTasks.add(board);
          } catch (e) {
            rethrow;
          }
          if (!listEquals(_teams, newTasks)) {
            _teams = newTasks;
          }
        }
      });

      return _teams;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> saveTeam(TeamModel data) async {
    bool hasId = data.teamId.isNotEmpty;

    final team = TeamModel(
      teamId: hasId ? data.teamId : Random().nextDouble().toString(),
      teamName: data.teamId,
      projectId: data.projectId,
    );

    if (hasId) {
      return;
    } else {
      return await addTeam(team);
    }
  }

  Future<void> addTeam(TeamModel team) async {
    final response = await dio.dio.post(
      'teams.json?auth=$_token',
      data: {
        "id": team.teamId,
        "teamName": team.teamName,
        "projectId": team.projectId,
      },
    );

    final id = response.data["name"];

    _teams.add(
      TeamModel(
        teamId: id,
        projectId: team.projectId,
        teamName: team.teamName,
      ),
    );
  }
}
