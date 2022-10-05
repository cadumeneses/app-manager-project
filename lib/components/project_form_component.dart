import 'package:app_manager_project/models/project.dart';
import 'package:app_manager_project/models/project_list.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectFormComponent extends StatefulWidget {
  const ProjectFormComponent({super.key});

  @override
  State<ProjectFormComponent> createState() => _ProjectFormComponentState();
}

class _ProjectFormComponentState extends State<ProjectFormComponent> {
  final _descriptionFocus = FocusNode();
  final _nameFocus = FocusNode();

  final _formData = Map<String, Object>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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


    try {
      await Provider.of<ProjectList>(
        context,
        listen: false,
      ).saveProject(_formData);
    } catch (e) {
        debugPrint('error:' + e.toString());
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
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
              child: Text(
                'Novo projeto',
                style: TextStyle(
                    color: CustomColor.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              initialValue: _formData['name']?.toString(),
              decoration:
                  const InputDecoration(labelText: 'Nome do projeto'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
              onSaved: (name) => _formData['name'] = name ?? '',
              validator: (_name) {
                final name = _name ?? '';

                if (name.trim().isEmpty) {
                  return 'The name is invalid!';
                }

                if (name.trim().length < 5) {
                  return 'The name need min 5 letters';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _formData['description']?.toString(),
              decoration: const InputDecoration(labelText: 'Descrição'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocus);
              },
              autofocus: false,
              onSaved: (description) =>
                  _formData['description'] = description ?? '',
              validator: (_description) {
                final description = _description ?? '';

                if (description.trim().isEmpty) {
                  return 'The description is invalid!';
                }

                if (description.trim().length < 3) {
                  return 'The description need min 10 letters';
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: _submitForm, child: const Text('Criar projeto'))
          ],
        ),
      ),
    );
  }
}
