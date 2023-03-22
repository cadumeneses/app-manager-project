import 'dart:math';

import 'package:app_manager_project/core/board/infra/models/board_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BoardRepository extends ChangeNotifier {
  var dio = Dio();

  final String _token;
  final String _uid;

  List<Board> _boardItems = [];
  List<Board> get boards => [..._boardItems];

  BoardRepository([
    this._token = '',
    this._uid = '',
    this._boardItems = const [],
  ]);

  int get boardCount {
    return _boardItems.length;
  }

  Future<void> loadBoards() async {
    _boardItems.clear();
    try {
      final response = await dio.get('https://taskforce-47f99-default-rtdb.firebaseio.com//boards.json?auth=$_token');
      debugPrint(boards.length.toString());
      Map<String, dynamic> data = response.data;
      data.forEach((boardId, boardData) {
        _boardItems.add(Board(
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
    final response = await dio.post(
      'https://taskforce-47f99-default-rtdb.firebaseio.com/boards.json?auth=$_token',
      data: {
        "id": board.id,
        "name": board.name,
      },
    );

    final id = response.data["name"];
    _boardItems.add(Board(
      id: id,
      name: board.name,
    ));

    notifyListeners();
  }
}
