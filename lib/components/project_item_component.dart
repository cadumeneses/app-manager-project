import 'package:app_manager_project/components/chart_component.dart';
import 'package:flutter/material.dart';

class ProjectItemComponent extends StatelessWidget {
  const ProjectItemComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/ondas.jpg',
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
                        const Text(
                          'Project Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.create))
                      ],
                    ),
                    Row(
                       children: const [
                        Text(
                          'Project description - ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        ),
                        Text(
                          'Sep 26, 2022',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const ChartComponent(percentage: 0.8))
            ],
          ),
        ),
      ),
    );
  }
}
