import 'package:flutter/material.dart';
import 'components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 180,
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).size.height * 0.15,
                0,
                30,
              ),
              child: Text(
                'Entre na sua conta',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
            const AuthForm(),
          ],
        ),
      ),
    );
  }
}
