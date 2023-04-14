import 'package:app_manager_project/features/team/presenters/person_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/components/form/input_submit_form.dart';
import '../../../core/components/form/input_text_form.dart';

class TeamForm extends StatefulWidget {
  const TeamForm({super.key});

  @override
  State<TeamForm> createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _occupationController = TextEditingController();

  late PersonPresenter presenter;

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

    return SingleChildScrollView(
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
                  'Adicionar novo membro',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              InputTextForm(
                label: "Nome",
                minLenght: 3,
                controller: _firstNameController,
              ),
              const SizedBox(height: 20),
              InputTextForm(
                label: "Sobrenome",
                minLenght: 3,
                controller: _lastNameController,
              ),
              const SizedBox(height: 20),
              InputTextForm(
                label: "Cargo",
                minLenght: 3,
                controller: _occupationController,
              ),
              const SizedBox(height: 20),
              InputSubmitForm(
                color: colorScheme.primary,
                submitForm: () {
                  presenter.savePerson(
                    _firstNameController.text,
                    _lastNameController.text,
                    _occupationController.text,
                  );
                  Navigator.of(context).pop();
                },
                nameButton: 'Adicionar Membro',
                labelColor: colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
