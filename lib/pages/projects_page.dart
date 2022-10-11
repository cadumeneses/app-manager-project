import 'package:app_manager_project/components/filter_kanban_component.dart';
import 'package:app_manager_project/components/project_item_component.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';

import '../data/project_data.dart';
import '../models/project.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Project> projectsList = data;
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
                          height: 50,
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
              const SizedBox(height: 20),
              const FilterKanbanComponent(),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  scrollDirection: Axis.vertical,
                  itemCount: projectsList.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return const ProjectItemComponent();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
