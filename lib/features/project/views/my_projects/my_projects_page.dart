import 'package:app_manager_project/features/project/models/project_repository.dart';
import 'package:app_manager_project/features/project/views/my_projects/components/chips_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/project_item_component.dart';

class MyProjectsPage extends StatelessWidget {
  const MyProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meus Projetos',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: colorScheme.onBackground,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const ChipsComponent(),
              Container(
                padding: EdgeInsets.only(top: availableHeight * 0.01),
                height: availableHeight * 0.77,
                child: Consumer<ProjectRepository>(
                    builder: (_, projectRepository, widget) {
                  return ListView.separated(
                    itemCount: projectRepository.projects.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) {
                      var project = projectRepository.projects[index];
                      return ProjectItemComponent(
                        name: project.name,
                        imgUrl: project.imgUrl,
                        description: project.description,
                        project: project,
                      );
                    }),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
