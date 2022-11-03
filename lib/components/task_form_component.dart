import 'package:app_manager_project/models/project.dart';
import 'package:app_manager_project/models/project_list.dart';
import 'package:app_manager_project/models/task.dart';
import 'package:app_manager_project/models/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom_color.dart';
import 'form/input_submit_form.dart';
import 'form/input_text_form.dart';

class TaskFormComponent extends StatefulWidget {
  const TaskFormComponent({super.key});

  @override
  State<TaskFormComponent> createState() => _TaskFormComponentState();
}

class _TaskFormComponentState extends State<TaskFormComponent> {
  var project = Project(
    id: '',
    name: "",
    description: "",
    imgUrl: "",
  );
  final _nameFocus = FocusNode();

  final _formData = <String, Object>{};
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<Project>> projects() {
    var itens = <DropdownMenuItem<Project>>[];
    for (var i = 0;
        i < Provider.of<ProjectList>(context).projects.length;
        i++) {
      itens.add(
        DropdownMenuItem(
            value: Provider.of<ProjectList>(context).projects.elementAt(i),
            child: Text(
                Provider.of<ProjectList>(context).projects.elementAt(i).name)),
      );
    }
    return itens;
  }

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final task = argument as Task;
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
                    const SizedBox(height: 10),
                    InputTextForm(
                        formData: _formData,
                        formDataTitle: "name",
                        titleFocus: _nameFocus,
                        label: "Nome",
                        minLenght: 3),
                    const SizedBox(height: 20),
                    Consumer<ProjectList>(
                      builder: (_,projectRepository, widget) {
                        return DropdownButton(
                          hint: const Text('Nenhum projeto selecionado'),
                          items: projectRepository.projects.map<DropdownMenuItem<Project>>(
                            (final Project value){
                              return DropdownMenuItem<Project>(value: value,child: Text(value.name),);
                            }
                          ).toList(),
                          onChanged: (value){
                             setState(() {
                                projectRepository.projects.where((element) => element == value);
                             });
                          },
                        );
                      }
                    ),
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
