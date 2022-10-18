import 'package:app_manager_project/components/form/input_date_form.dart';
import 'package:app_manager_project/models/person.dart';
import 'package:app_manager_project/models/person_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom_color.dart';
import 'form/input_submit_form.dart';
import 'form/input_text_form.dart';

class ProfileFormComponent extends StatefulWidget {
  const ProfileFormComponent({super.key});

  @override
  State<ProfileFormComponent> createState() => _ProfileFormComponentState();
}

class _ProfileFormComponentState extends State<ProfileFormComponent> {
  final _occupationFocus = FocusNode();
  final _nameFocus = FocusNode();

  final _formData = <String, Object>{};
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate = DateTime(2010);

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final person = argument as Person;
        _formData['id'] = person.id;
        _formData['name'] = person.name;
        _formData['occupation'] = person.occupation;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _occupationFocus.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<PersonRepository>(
        context,
        listen: false,
      ).savePerson(_formData);
    } catch (e) {
      debugPrint(e.toString());
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Erro ao editar perfil'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sair'),
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
        ? const Center(
            child: CircularProgressIndicator(color: CustomColor.secondaryColor))
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.88,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.keyboard_arrow_left,
                                size: 30, color: Colors.grey.shade400),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text(
                              'Editar Seu Perfil',
                              style: TextStyle(
                                  color: CustomColor.primaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
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
                    InputDateForm(
                      selectedDate: _selectedDate,
                      onDateChange: (newDate) {
                        setState(() {
                          _selectedDate = newDate;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    InputTextForm(
                        formData: _formData,
                        formDataTitle: "occupation",
                        titleFocus: _occupationFocus,
                        label: "Profissão",
                        minLenght: 10),
                    const SizedBox(height: 25),
                    InputSubmitForm(
                        color: CustomColor.secondaryColor,
                        submitForm: _submitForm,
                        nameButton: 'Criar Projeto')
                  ],
                ),
              ),
            ),
          );
  }
}
