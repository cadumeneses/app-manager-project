import 'package:app_manager_project/core/board/models/board_model.dart';
import 'package:app_manager_project/core/board/models/board_repository.dart';
import 'package:flutter/material.dart';

class BoardPresenter with ChangeNotifier {
  final BoardRepository _boardRepository;
  bool _isLoading = false;
  String _error = '';
  List<BoardModel> _boards = [];
  List<BoardModel> get boards => [..._boards];

  BoardPresenter(this._boardRepository);

  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadBoards(String projectId) async {
    _isLoading = true;
    _error = '';
    try {
      _boards = await _boardRepository.loadBoards(projectId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveBoard(
      String boardName, String projectId, DateTime? data) async {
    _isLoading = true;
    _error = '';
    try {
      await _boardRepository.saveBoard(
        BoardModel(
          id: '',
          name: boardName,
          projectId: projectId,
          dataVersion: data,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      loadBoards(projectId);
      notifyListeners();
    }
  }
}
