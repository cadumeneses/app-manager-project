import 'package:app_manager_project/features/project/infra/models/project_model.dart';
import 'package:app_manager_project/core/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'chart_component.dart';

class ProjectItemComponent extends StatelessWidget {
  const ProjectItemComponent({
    required this.project,
    required this.name,
    required this.imgUrl,
    required this.description,
    super.key,
  });

  final String name;
  final String imgUrl;
  final String description;
  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Container(
        height: 260,
        margin: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: ShapeDecoration(
          color: colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.projectsDetails,
              arguments: project,
            );
          },
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(14),
                height: 100,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: colorScheme.onBackground.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '$description - ',
                          style: textTheme.titleSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          'Sep 26, 2022',
                          style: textTheme.titleSmall
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                child: const ChartComponent(percentage: 0.8),
              )
            ],
          ),
        ),
      ),
    );
  }
}
