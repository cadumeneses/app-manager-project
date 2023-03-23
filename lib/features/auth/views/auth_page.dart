import 'package:app_manager_project/features/auth/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presenters/auth_presenter.dart';
import 'components/email_input_component.dart';
import 'components/password_input_component.dart';
import 'components/submit_form_component.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

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
            ChangeNotifierProvider(
              create: (_) => AuthPresenter(
                Provider.of<AuthModel>(context, listen: false),
              ),
              child: Consumer<AuthPresenter>(builder: (context, presenter, _) {
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        EmailInputComponent(emailController: _emailController),
                        const SizedBox(height: 20),
                        PasswordInputComponent(
                          passwordController: _passwordController,
                        ),
                        const SizedBox(height: 40),
                        if (presenter.isLoading)
                          CircularProgressIndicator(
                            color: colorScheme.primary,
                          )
                        else
                          SubmitFormComponent(
                            presenter: presenter,
                            textTheme: textTheme,
                            colorScheme: colorScheme,
                            submitCallback: () => presenter.submit(
                              _emailController.text,
                              _passwordController.text,
                            ),
                          ),
                        TextButton(
                          onPressed: presenter.switchAuthMode,
                          child: Text(
                            presenter.authMode == AuthMode.login
                                ? "Não tem uma conta? Cadastre-se!"
                                : 'Já tem uma conta? Entrar',
                            style: textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
