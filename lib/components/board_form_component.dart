import 'package:app_manager_project/components/form/input_text_form.dart';
import 'package:app_manager_project/models/board_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board.dart';
import '../utils/custom_color.dart';
import 'form/input_submit_form.dart';

class BoardFormComponent extends StatefulWidget {
  const BoardFormComponent({super.key});

  @override
  State<BoardFormComponent> createState() => _BoardFormComponentState();
}

class _BoardFormComponentState extends State<BoardFormComponent> {
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
        final board = argument as Board;
        _formData['id'] = board.id;
        _formData['name'] = board.name;
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
      await Provider.of<BoardRepository>(
        context,
        listen: false,
      ).saveBoard(_formData);
    } catch (e) {
      debugPrint(e.toString());
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: Text(e.toString()),
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
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(color: CustomColor.secondaryColor))
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
                      'Adicionar nova placa',
                      style: TextStyle(
                          color: CustomColor.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(thickness: 1),
                  InputTextForm(
                      formData: _formData,
                      formDataTitle: "name",
                      titleFocus: _nameFocus,
                      label: "Nome",
                      minLenght: 3),
                  const SizedBox(height: 10),
                  InputSubmitForm(
                    color: CustomColor.secondaryColor,
                    nameButton: "Criar nova placa",
                    submitForm: _submitForm,
                  )
                ],
              ),
            ),
          ));
  }
}
