import 'package:flutter/material.dart';

class EmailInputComponent extends StatelessWidget {
  const EmailInputComponent({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

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
          hintText: "E-mail",
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          icon: Icon(Icons.email),
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (_email) {
          final email = _email ?? '';
          if (email.trim().isEmpty || !email.contains('@')) {
            return 'Insira um e-mail válido!';
          }
          return null;
        },
      ),
    );
  }
}
