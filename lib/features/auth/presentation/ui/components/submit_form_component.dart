import 'package:flutter/material.dart';
import 'auth_form.dart';

class SubmitFormComponent extends StatelessWidget {
  final AuthMode authMode;
  final VoidCallback submitCallback;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const SubmitFormComponent({
    super.key,
    required this.authMode,
    required this.submitCallback,
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: submitCallback,
      child: Container(
        width: size.width * 0.92,
        height: 60,
        decoration: ShapeDecoration(
          color: colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Center(
          child: Text(
            authMode == AuthMode.login ? 'Entrar' : 'Cadastrar',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
