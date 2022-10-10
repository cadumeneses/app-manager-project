import 'package:flutter/material.dart';

import '../models/board.dart';
import '../utils/custom_color.dart';

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
                      textInputAction: TextInputAction.done,
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
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: (){},
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Center(
                        child: Text(
                          'Criar nova placa',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}
