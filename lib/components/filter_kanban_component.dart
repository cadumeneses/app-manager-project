import '../utils/custom_color.dart';
import 'package:flutter/material.dart';

class FilterKanbanComponent extends StatelessWidget {
  const FilterKanbanComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 20),
      width: double.infinity,
      height: 40,
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
    return InkWell(
      onTap: () {},
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.whiteColor,
            border: Border.all(
              color: CustomColor.primaryColor,
              width: 2,
            )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              nameButtom,
              style: const TextStyle(
                  color: CustomColor.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
