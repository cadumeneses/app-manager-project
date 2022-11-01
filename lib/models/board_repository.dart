import 'dart:math';

import 'package:app_manager_project/models/board.dart';
import 'package:app_manager_project/services/dio.dart';
import 'package:flutter/material.dart';

class BoardRepository with ChangeNotifier {
  var dio = DioClient();

  final String _token;
  final String _uid;

  List<Board> boardItems = [];

  BoardRepository([
    this._token = '',
    this._uid = '',
    this.boardItems = const [],
  ]);

  List<Board> get items {
    return [...boardItems];
  }

  int get boardCount {
    return boardItems.length;
  }

  Future<void> loadBoards() async {
    boardItems.clear();
    try {
      final response = await dio.dio.get('boards.json?auth=$_token');
      Map<String, dynamic> data = response.data;
      data.forEach((boardId, boardData) {
        boardItems.add(Board(
          id: boardId,
          name: boardData['name'],
        ));
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveBoard(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;

    final board = Board(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
    );

    if (hasId) {
      return;
    } else {
      return await addBoard(board);
    }
  }

  Future<void> addBoard(Board board) async {
    final response = await dio.dio.post(
      'https://manager-projects-flutter-default-rtdb.firebaseio.com/boards.json?auth=$_token',
      data: {
        "id": board.id,
        "name": board.name,
      },
    );

    final id = response.data["name"];
    boardItems.add(Board(
      id: id,
      name: board.name,
    ));

    notifyListeners();
  }
}
