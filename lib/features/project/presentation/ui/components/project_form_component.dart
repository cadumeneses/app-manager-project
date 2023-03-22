import 'package:app_manager_project/core/components/form/input_text_form.dart';
import 'package:app_manager_project/features/project/infra/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/components/form/input_submit_form.dart';
import '../../../infra/repositories/project_repository.dart';

class ProjectFormComponent extends StatefulWidget {
  const ProjectFormComponent({super.key});

  @override
  State<ProjectFormComponent> createState() => _ProjectFormComponentState();
}

class _ProjectFormComponentState extends State<ProjectFormComponent> {
  final _descriptionFocus = FocusNode();
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
        final project = argument as Project;
        _formData['id'] = project.id;
        _formData['name'] = project.name;
        _formData['description'] = project.description;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _descriptionFocus.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProjectRepository>(
        context,
        listen: false,
      ).saveProject(_formData);
    } catch (e) {
      debugPrint(e.toString());
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error has occurred!'),
          content: const Text('Error to save product'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Back'),
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
                      icon: Icon(Icons.keyboard_arrow_down,
                          size: 40, color: Colors.grey.shade400),
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
                      formData: _formData,
                      formDataTitle: "name",
                      titleFocus: _nameFocus,
                      label: "Nome",
                      minLenght: 3,
                    ),
                    const SizedBox(height: 20),
                    InputTextForm(
                      formData: _formData,
                      formDataTitle: "description",
                      titleFocus: _descriptionFocus,
                      label: "Descrição",
                      minLenght: 10,
                    ),
                    const SizedBox(height: 25),
                    InputSubmitForm(
                      color: colorScheme.primary,
                      submitForm: _submitForm,
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
