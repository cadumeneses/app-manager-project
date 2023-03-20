import 'package:app_manager_project/core/utils/custom_color.dart';
import 'package:flutter/material.dart';

class PasswordInputComponent extends StatelessWidget {
  const PasswordInputComponent({
    super.key,
    required TextEditingController passwordController,
    required Map<String, String> authData,
  }) : _passwordController = passwordController, _authData = authData;

  final TextEditingController _passwordController;
  final Map<String, String> _authData;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          if (password.trim().isEmpty || password.length < 5) {
            return 'Insira uma senha válida!';
          }
          return null;
        },
      ),
    );
  }
}