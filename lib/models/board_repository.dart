import 'dart:math';

import 'package:app_manager_project/models/board.dart';
import 'package:app_manager_project/models/task.dart';
import 'package:app_manager_project/services/dio.dart';
import 'package:flutter/material.dart';

class BoardRepository with ChangeNotifier {
  var dio = DioClient();

  final String token;

  List<Board> boardItems = [];

  BoardRepository([
    this.token = '',
    this.boardItems = const [],
  ]);

  List<Board> get items {
    return [...boardItems];
  }

  int get boardCount {
    return boardItems.length;
  }

  Future<void> loadBoards() async {
    List<Board> items = [];
    final response = await dio.dio.get(
        'https://manager-projects-flutter-default-rtdb.firebaseio.com/boards.json?auth=$token');
    Map<String, dynamic> data = response.data;
    data.forEach((boardId, boardData) {
      items.add(Board(
        id: boardId,
        name: boardData['name'],
        tasks: (boardData['tasks'] as List<dynamic>).map((e) {
          return Task(
              id: e['id'],
              name: e['name'],
              projectId: e['projectId'],
              dateInit: DateTime.parse(e['dateInit']));
        }).toList(),
      ));
      boardItems = items.reversed.toList();
      notifyListeners();
    });
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
    await dio.dio.post(
      'https://manager-projects-flutter-default-rtdb.firebaseio.com/boards.json?auth=$token',
      data: {
        "id": board.id,
        "name": board.name,
      },
    );
    boardItems.add(Board(id: board.id, name: board.name));

    notifyListeners();
  }
}
