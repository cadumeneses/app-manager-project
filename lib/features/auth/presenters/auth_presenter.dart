import 'package:app_manager_project/features/auth/models/auth_exception.dart';
import 'package:app_manager_project/features/auth/models/auth_model.dart';
import 'package:flutter/material.dart';

enum AuthMode {
  signup,
  login,
}

class AuthPresenter with ChangeNotifier {
  final AuthModel _authModel;
  AuthMode authMode = AuthMode.login;
  bool _isLoading = false;
  String _error = '';

  AuthPresenter(this._authModel);

  bool get isLoading => _isLoading;

  String get error => _error;

  bool get isLogin => authMode == AuthMode.login;

  void switchAuthMode() {
    authMode = isLogin ? AuthMode.signup : AuthMode.login;
    notifyListeners();
  }

  Future<void> submit(String email, String password) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      if (isLogin) {
        await _authModel.login(email, password);
      } else {
        await _authModel.signup(email, password);
      }
    } on AuthExceptionModel catch (e) {
      _error = e.toString();
    } catch (e) {
      _error = 'Ocorreu um erro inesperado!';
    }

    _isLoading = false;
    notifyListeners();
  }
}
