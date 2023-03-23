import 'package:app_manager_project/core/task/models/task_model.dart';
import 'package:app_manager_project/core/task/models/tasks_repository.dart';
import 'package:app_manager_project/core/task/presenters/task_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/form/input_submit_form.dart';
import '../../components/form/input_text_form.dart';

class TaskFormComponent extends StatefulWidget {
  const TaskFormComponent({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<TaskFormComponent> createState() => _TaskFormComponentState();
}

class _TaskFormComponentState extends State<TaskFormComponent> {
  final _taskNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late TaskPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return presenter.isLoading
        ? const Center(child: CircularProgressIndicator())
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
                        'Criar Tarefa',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    InputTextForm(
                      label: "Nome",
                      minLenght: 3,
                      controller: _taskNameController,
                    ),
                    const SizedBox(height: 20),
                    InputSubmitForm(
                      color: colorScheme.primary,
                      submitForm: () {
                        presenter.submitForm(
                          _taskNameController.text,
                          widget.projectId,
                        );
                        Navigator.of(context).pop();
                      },
                      nameButton: 'Adicionar Tarefa',
                      labelColor: colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
