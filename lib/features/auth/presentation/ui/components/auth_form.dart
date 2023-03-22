import 'package:app_manager_project/features/auth/infra/repositories/exceptions/auth_exception.dart';
import 'package:app_manager_project/features/auth/presentation/ui/components/password_input_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../infra/repositories/auth_repository.dart';
import 'email_input_component.dart';
import 'submit_form_component.dart';

enum AuthMode { singup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;

  void switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.singup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    AuthRepository auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            EmailInputComponent(authData: _authData),
            const SizedBox(height: 20),
            PasswordInputComponent(
              passwordController: _passwordController,
              authData: _authData,
            ),
            const SizedBox(height: 40),
            if (_isLoading)
              CircularProgressIndicator(
                color: colorScheme.primary,
              )
            else
              SubmitFormComponent(
                authMode: _authMode,
                submitCallback: submit,
                textTheme: textTheme,
                colorScheme: colorScheme,
              ),
            TextButton(
              onPressed: switchAuthMode,
              child: Text(
                _isLogin()
                    ? "Não tem uma conta? Cadastre-se!"
                    : 'Já tem uma conta? Entrar',
                style: textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
