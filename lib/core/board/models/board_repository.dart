import 'dart:math';

import 'package:app_manager_project/core/board/models/board_model.dart';
import 'package:app_manager_project/core/external/dio/dio_client.dart';
import 'package:flutter/foundation.dart';

class BoardRepository {
  var dio = DioClient();

  final String _token;
  final String _uid;

  List<BoardModel> _boards = [];
  List<BoardModel> get boards => [..._boards];

  BoardRepository([
    this._token = '',
    this._uid = '',
    this._boards = const [],
  ]);

  int get boardCount {
    return _boards.length;
  }

  Future<List<BoardModel>> loadBoards(String projectId) async {
    try {
      final response = await dio.dio.get(
        'https://taskforce-47f99-default-rtdb.firebaseio.com/boards.json?auth=$_token',
      );

      if (response.data == null) {
        return [];
      }

      Map<String, dynamic> data = response.data;
      List<BoardModel> newBoards = [];

      if (data.isEmpty) {
        _boards = [];
      }

      data.forEach((boardId, boardData) {
        if (boardData['projectId'] == projectId) {
          try {
            BoardModel board = BoardModel(
              id: boardId,
              name: boardData['name'],
              projectId: boardData['projectId'],
              dataVersion: boardData['dataVersion'],
            );
            newBoards.add(board);
          } catch (e) {
            debugPrint(e.toString());
            rethrow;
          }
          if (!listEquals(_boards, newBoards)) {
            _boards = newBoards;
          }
        }
      });

      return _boards;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> saveBoard(BoardModel data) async {
    bool hasId = data.id.isNotEmpty;

    final board = BoardModel(
      id: hasId ? data.id : Random().nextDouble().toString(),
      name: data.name,
      projectId: data.projectId,
      dataVersion: data.dataVersion,
    );

    if (hasId) {
      return;
    } else {
      return await addBoard(board);
    }
  }

  Future<void> addBoard(BoardModel board) async {
    final response = await dio.dio.post(
      'https://taskforce-47f99-default-rtdb.firebaseio.com/boards.json?auth=$_token',
      data: {
        "id": board.id,
        "name": board.name,
        "projectId": board.projectId,
      },
    );

    final id = response.data["name"];
    _boards.add(BoardModel(
      id: id,
      name: board.name,
      projectId: board.projectId,
      dataVersion: board.dataVersion,
    ));
  }
}
