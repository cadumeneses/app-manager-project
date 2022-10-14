import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../exceptions/auth_exceptions.dart';
import '../models/auth.dart';

enum AuthMode { singup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  bool _isLogin() => _authMode == AuthMode.login;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );
    _authMode = AuthMode.login;
    _controller?.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.singup;
        _controller?.forward();
      } else {
        _authMode = AuthMode.login;
        _controller?.forward();
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

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

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
    } on AuthExceptions catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              padding: const EdgeInsets.all(5),
              child: SlideTransition(
                position: _slideAnimation!,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.white),
                        )),
                        child: TextFormField(
                          style: const TextStyle(
                            color: CustomColor.whiteColor,
                          ),
                          decoration: const InputDecoration(
                            hintText: "E-mail",
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) => _authData['email'] = email ?? '',
                          validator: (_email) {
                            final email = _email ?? '';
                            if (email.trim().isEmpty || !email.contains('@')) {
                              return 'Insira um e-mail válido!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.white),
                        )),
                        child: TextFormField(
                          style: const TextStyle(
                            color: CustomColor.whiteColor,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Senha",
                            hintStyle: TextStyle(color: Colors.white),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          controller: _passwordController,
                          onSaved: (password) =>
                              _authData['password'] = password ?? '',
                          validator: (_password) {
                            final password = _password ?? '';
                            if (password.trim().isEmpty ||
                                password.length < 5) {
                              return 'Insira uma senha válida!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const CircularProgressIndicator(
                color: CustomColor.secondaryColor,
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 30,
                    ),
                  ),
                  child: SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Center(
                      child: Text(
                        _authMode == AuthMode.login ? 'Entrar' : 'Cadastrar',
                        style: const TextStyle(
                            color: CustomColor.primaryColor, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                  _isLogin()
                      ? "Não tem uma conta? Cadastre-se!"
                      : 'Já tem uma conta? Entrar',
                  style: _isLogin()
                      ? const TextStyle(
                          color: CustomColor.whiteColor, fontSize: 16)
                      : const TextStyle(
                          color: CustomColor.secondaryColor, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
