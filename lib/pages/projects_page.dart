import 'package:app_manager_project/components/filter_kanban_component.dart';
import 'package:app_manager_project/components/project_item_component.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../models/project_list.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectList>(context);
    final List<Project> loadedProjects = provider.projects;

    final availableHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;


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
              const FilterKanbanComponent(),
              Container(
                padding: EdgeInsets.only(top: availableHeight * 0.01),
                height: availableHeight * 0.77,
                child: ListView.builder(
                  itemCount: loadedProjects.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) =>
                      ChangeNotifierProvider.value(
                        value: loadedProjects[index],
                        child: const ProjectItemComponent(),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
