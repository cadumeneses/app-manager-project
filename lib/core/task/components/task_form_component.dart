import 'package:app_manager_project/features/project/infra/repositories/project_repository.dart';
import 'package:app_manager_project/core/task/infra/models/task_model.dart';
import 'package:app_manager_project/core/task/infra/repositories/tasks_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/project/infra/models/project_model.dart';
import '../../utils/custom_color.dart';
import '../../components/form/input_submit_form.dart';
import '../../components/form/input_text_form.dart';

class TaskFormComponent extends StatefulWidget {
  const TaskFormComponent({super.key});

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
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 20 + MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_down,
                          size: 40, color: Colors.grey.shade400),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        'Criar Tarefa',
                        style: TextStyle(
                            color: CustomColor.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(),
                    InputTextForm(
                        formData: _formData,
                        formDataTitle: "name",
                        titleFocus: _nameFocus,
                        label: "Nome",
                        minLenght: 3),
                    const SizedBox(height: 20),
                    Consumer<ProjectRepository>(
                        builder: (_, projectRepository, widget) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                          value: projectRepository.projects.first,
                          isExpanded: true,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
                          items: projectRepository.projects
                              .map<DropdownMenuItem<Project>>(
                                  (final Project value) {
                            return DropdownMenuItem<Project>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              DropdownMenuItem<Project>(
                                  value: value, child: Text(value!.name));
                            });
                            debugPrint(value!.name.toString());
                          },
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    InputSubmitForm(
                        color: CustomColor.secondaryColor,
                        submitForm: _submitForm,
                        nameButton: 'Adicionar Tarefa')
                  ],
                ),
              ),
            ),
          );
  }
}
