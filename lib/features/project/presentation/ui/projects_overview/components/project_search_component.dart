import 'package:app_manager_project/core/utils/custom_color.dart';
import 'package:flutter/material.dart';

class ProjectSearchComponent extends StatefulWidget {
  const ProjectSearchComponent({super.key});

  @override
  State<ProjectSearchComponent> createState() => _ProjectSearchComponentState();
}

class _ProjectSearchComponentState extends State<ProjectSearchComponent> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: (value){},
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintText: " Procurar projeto",
            prefixIcon: Icon(Icons.search),
            prefixIconColor: CustomColor.secondaryColor
          ),
        ),
      ),
    );
  }
}