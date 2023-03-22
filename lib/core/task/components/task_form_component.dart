import 'package:app_manager_project/core/task/infra/models/task_model.dart';
import 'package:app_manager_project/core/task/infra/repositories/tasks_repository.dart';
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
  final _nameFocus = FocusNode();

  final _formData = <String, Object>{};
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final task = argument as TaskModel;
        _formData['id'] = task.id;
        _formData['name'] = task.name;
      }
        _formData['projectId'] = widget.projectId;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<TaskRepository>(
        context,
        listen: false,
      ).save(_formData);

    } catch (e) {
      debugPrint(e.toString());
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro'),
          content: const Text('Erro ao salvar tarefa!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return _isLoading
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
                      formData: _formData,
                      formDataTitle: "name",
                      titleFocus: _nameFocus,
                      label: "Nome",
                      minLenght: 3,
                    ),
                    const SizedBox(height: 20),
                    InputSubmitForm(
                      color: colorScheme.primary,
                      submitForm: _submitForm,
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
