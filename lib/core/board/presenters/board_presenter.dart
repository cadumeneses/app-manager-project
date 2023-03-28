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

  Future<void> loadBoards() async {
    _isLoading = true;
    _error = '';
    try {
      _boards = await _boardRepository.loadBoards();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
