import 'package:app_manager_project/core/board/presenters/board_presenter.dart';
import 'package:app_manager_project/core/components/form/input_date_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/form/input_submit_form.dart';
import '../../components/form/input_text_form.dart';

class BoardFormView extends StatefulWidget {
  const BoardFormView({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<BoardFormView> createState() => _BoardFormViewState();
}

class _BoardFormViewState extends State<BoardFormView> {
  final _taskNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late BoardPresenter presenter;

  DateTime? _selectedDate;

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
                        'Adicionar nova versão',
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
                    InputDateForm(
                      selectedDate: _selectedDate,
                      onDateChange: (newDate) {
                        setState(() {
                          _selectedDate = newDate;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    InputSubmitForm(
                      color: colorScheme.primary,
                      submitForm: () {
                        presenter.saveBoard(
                          _taskNameController.text,
                          widget.projectId,
                          _selectedDate,

                        );
                        Navigator.of(context).pop();
                      },
                      nameButton: 'Adicionar Versão',
                      labelColor: colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
