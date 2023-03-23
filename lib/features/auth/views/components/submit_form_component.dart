import 'package:app_manager_project/features/auth/presenters/auth_presenter.dart';
import 'package:flutter/material.dart';

class SubmitFormComponent extends StatelessWidget {
  final VoidCallback submitCallback;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final AuthPresenter presenter;

  const SubmitFormComponent({
    super.key,
    required this.submitCallback,
    required this.textTheme,
    required this.colorScheme, required this.presenter,
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
            presenter.authMode == AuthMode.login ? 'Entrar' : 'Cadastrar',
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
