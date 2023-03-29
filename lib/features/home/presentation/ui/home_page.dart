import 'package:app_manager_project/features/project/views/components/project_form_component.dart';
import 'package:app_manager_project/features/project/views/my_projects/my_projects_page.dart';
import 'package:app_manager_project/features/profile/views/profile_page.dart';
import 'package:flutter/material.dart';
import '../../../project/views/project_overview/projects_overview_page.dart';
import '../../../team/view/team_view.dart';

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
      const TeamView(),
      const ProfilePage(),
    ];

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: colorScheme.primary,
        showUnselectedLabels: true,
        unselectedItemColor: colorScheme.outline,
        selectedLabelStyle: style,
        unselectedLabelStyle: style,
        items: [
          const BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          const BottomNavigationBarItem(
            label: 'Projetos',
            icon: Icon(Icons.text_snippet),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: colorScheme.primary,
              minRadius: 30,
              child: Icon(
                Icons.add,
                size: 50,
                color: colorScheme.onPrimary,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            label: 'Equipe',
            icon: Icon(Icons.diversity_3),
          ),
          const BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(Icons.account_circle),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
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
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
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
