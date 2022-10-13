import 'package:app_manager_project/components/form/input_text_form.dart';
import 'package:flutter/material.dart';

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
              submitForm: () {},
            )
          ],
        ),
      ),
    ));
  }
}
