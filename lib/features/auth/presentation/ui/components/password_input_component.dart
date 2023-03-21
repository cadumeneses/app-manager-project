import 'package:flutter/material.dart';

class PasswordInputComponent extends StatelessWidget {
  const PasswordInputComponent({
    super.key,
    required TextEditingController passwordController,
    required Map<String, String> authData,
  })  : _passwordController = passwordController,
        _authData = authData;

  final TextEditingController _passwordController;
  final Map<String, String> _authData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.primary),
        ),
      ),
      child: TextFormField(
        style: theme.textTheme.labelMedium,
        decoration: const InputDecoration(
          hintText: "Senha",
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        controller: _passwordController,
        onSaved: (password) => _authData['password'] = password ?? '',
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
