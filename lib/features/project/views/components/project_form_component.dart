import 'package:app_manager_project/core/components/form/input_text_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/form/input_submit_form.dart';
import '../../presenters/project_presenter.dart';

class ProjectFormComponent extends StatefulWidget {
  const ProjectFormComponent({super.key});

  @override
  State<ProjectFormComponent> createState() => _ProjectFormComponentState();
}

class _ProjectFormComponentState extends State<ProjectFormComponent> {
  final _descriptionController = TextEditingController();
  final _nameControlller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late ProjectPresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = context.read<ProjectPresenter>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argument = ModalRoute.of(context)?.settings.arguments;
    presenter.setArguments(argument);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return presenter.isLoading
        ? Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          )
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        'Novo projeto',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    InputTextForm(
                      label: "Nome",
                      minLenght: 3,
                      controller: _nameControlller,
                    ),
                    const SizedBox(height: 20),
                    InputTextForm(
                      label: "Descrição",
                      minLenght: 10,
                      controller: _descriptionController,
                    ),
                    const SizedBox(height: 25),
                    InputSubmitForm(
                      color: colorScheme.primary,
                      submitForm: () {
                        presenter.submitForm(
                          _nameControlller.text,
                          _descriptionController.text,
                        );
                        Navigator.of(context).pop();
                      },
                      nameButton: 'Criar Projeto',
                      labelColor: colorScheme.onPrimaryContainer,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
