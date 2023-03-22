import 'package:app_manager_project/features/project/presentation/ui/components/project_form_component.dart';
import 'package:app_manager_project/features/project/presentation/ui/my_projects/my_projects_page.dart';
import 'package:app_manager_project/features/profile/presentation/ui/profile_page.dart';
import 'package:flutter/material.dart';
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

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: colorScheme.primaryContainer,
        showUnselectedLabels: true,
        unselectedItemColor: colorScheme.outline,
        selectedLabelStyle: style,
        unselectedLabelStyle: style,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Projetos',
            icon: Icon(Icons.text_snippet),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              minRadius: 30,
              child: Icon(
                Icons.add,
                size: 50,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            label: 'Equipe',
            icon: Icon(Icons.diversity_3),
          ),
          BottomNavigationBarItem(
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
