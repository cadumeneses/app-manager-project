import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDateForm extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime)? onDateChange;

  const InputDateForm({this.selectedDate, this.onDateChange, Key? key}) : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2010),
      firstDate: DateTime(1980),
      lastDate: DateTime(2010),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChange!(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Informe seu aniversário'
                  : DateFormat('dd/MM/y').format(selectedDate!),
            ),
            IconButton(
              onPressed: () => _showDatePicker(context),
              icon: const Icon(Icons.calendar_month),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
