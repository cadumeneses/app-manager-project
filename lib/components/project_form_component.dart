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

  final _formData = <String, Object>{};
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
                  'Novo projeto',
                  style: TextStyle(
                      color: CustomColor.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  initialValue: _formData['name']?.toString(),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_nameFocus);
                  },
                  autofocus: false,
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (_name) {
                    final name = _name ?? '';

                    if (name.trim().isEmpty) {
                      return 'The name is invalid!';
                    }

                    if (name.trim().length < 3) {
                      return 'The name need min 10 letters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  initialValue: _formData['description']?.toString(),
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
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
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: _submitForm,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Center(
                    child: Text(
                      'Criar projeto',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
