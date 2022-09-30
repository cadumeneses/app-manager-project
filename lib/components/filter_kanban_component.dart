import '../utils/custom_color.dart';
import 'package:flutter/material.dart';

class FilterKanbanComponent extends StatelessWidget {
  const FilterKanbanComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 20),
      width: double.infinity,
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          ItemKanbanComponent(
            nameButtom: 'To-Do',
          ),
          SizedBox(width: 10),
          ItemKanbanComponent(
            nameButtom: 'Em progresso',
          ),
          SizedBox(width: 10),
          ItemKanbanComponent(
            nameButtom: 'Em teste',
          ),
          SizedBox(width: 10),
          ItemKanbanComponent(
            nameButtom: 'Finalizado',
          ),
        ],
      ),
    );
  }
}

class ItemKanbanComponent extends StatelessWidget {
  const ItemKanbanComponent({required this.nameButtom, super.key});

  final String nameButtom;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: CustomColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      autofocus: true,
      clipBehavior: Clip.hardEdge,
      child: Text(
        nameButtom,
        style: const TextStyle(color: CustomColor.primaryColor, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}
