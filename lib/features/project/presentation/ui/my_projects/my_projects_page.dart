import 'package:app_manager_project/features/project/infra/repositories/project_repository.dart';
import 'package:app_manager_project/core/utils/custom_color.dart';
import 'package:app_manager_project/features/project/presentation/ui/my_projects/components/chips_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/project_item_component.dart';


class MyProjectsPage extends StatelessWidget {
  const MyProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/brisa_logo1.png',
                          height: availableHeight * 0.05,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Meus Projetos',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.primaryColor),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search,
                          color: CustomColor.secondaryColor, size: 30),
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
                  return ListView.builder(
                      itemCount: projectRepository.projects.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        var project = projectRepository.projects[index];
                        return ProjectItemComponent(
                            name: project.name,
                            imgUrl: project.imgUrl,
                            description: project.description, project: project,);
                      }));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}