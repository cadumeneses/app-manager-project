import 'package:flutter/material.dart';

class PasswordInputComponent extends StatelessWidget {
  const PasswordInputComponent({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        color: colorScheme.outline.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: theme.textTheme.titleMedium,
        decoration: const InputDecoration(
          hintText: "Senha",
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          icon: Icon(Icons.lock),
        ),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        controller: passwordController,
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
