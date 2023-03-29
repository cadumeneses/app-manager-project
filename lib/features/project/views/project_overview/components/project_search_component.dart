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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: colorScheme.outline.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: (value) {},
          controller: _controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.all(15),
              hintText: " Procurar projeto",
              hintStyle: textTheme.titleMedium?.copyWith(
                color: colorScheme.outline.withOpacity(0.7),
              ),
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: colorScheme.outline.withOpacity(0.7)),
        ),
      ),
    );
  }
}
