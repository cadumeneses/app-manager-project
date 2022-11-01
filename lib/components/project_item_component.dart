import 'package:app_manager_project/components/chart_component.dart';
import 'package:app_manager_project/models/project.dart';
import 'package:app_manager_project/utils/app_routes.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';

class ProjectItemComponent extends StatelessWidget {
  const ProjectItemComponent({required this.project, required this.name, required this.imgUrl, required this.description, super.key});

  final String name;
  final String imgUrl;
  final String description;
  final Project project;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.projectsDetails, arguments: project);
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
                  padding: const EdgeInsets.all(10),
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Barlow',
                                color: CustomColor.primaryColor),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.create,
                                  color: CustomColor.secondaryColor))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '$description - ',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const Text(
                            'Sep 26, 2022',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: const ChartComponent(percentage: 0.8))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
