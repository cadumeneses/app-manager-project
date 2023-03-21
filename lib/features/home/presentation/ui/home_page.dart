import 'package:app_manager_project/features/project/presentation/ui/components/porject_form_component.dart';
import 'package:app_manager_project/features/project/presentation/ui/my_projects/my_projects_page.dart';
import 'package:app_manager_project/features/profile/presentation/ui/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../project/presentation/ui/projects_overview/projects_overview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final List<Widget> screens = [
      const ProjectsOverviewPage(),
      const MyProjectsPage(),
      const ProjectsOverviewPage(),
      const ProjectsOverviewPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            gap: 8,
            backgroundColor: colorScheme.primary,
            color: colorScheme.onPrimary.withOpacity(0.6),
            activeColor: colorScheme.onPrimary,
            textSize: 30,
            tabs: [
              const GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              const GButton(
                icon: Icons.list_alt_sharp,
                text: 'Projetos',
              ),
              GButton(
                icon: Icons.add,
                iconColor: colorScheme.onPrimary,
                border: Border.all(color: colorScheme.onPrimary, width: 2),
              ),
              const GButton(
                icon: Icons.people,
                text: 'Equipes',
              ),
              const GButton(
                icon: Icons.person,
                text: 'Perfil',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (int index) {
              switch (index) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  showModal(context);
                  break;
              }
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const ProjectFormComponent();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
