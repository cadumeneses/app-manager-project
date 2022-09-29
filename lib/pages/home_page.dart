import 'package:flutter/material.dart';
import 'package:app_manager_project/pages/projects_overview_page.dart';
import 'package:app_manager_project/pages/projects_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    final List<Widget> _screens = [
      const ProjectsOverviewPage(),
      const ProjectsPage(),
    ];

    void changeScreen(int indice) {
      setState(() {
        _selectedIndex = indice;
      });
    }

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color:Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              gap: 8,
              backgroundColor: Colors.blue,
              color: Colors.white,
              activeColor: Colors.blue,
              tabBackgroundColor: Colors.grey.shade200,
              textSize: 30,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.list_alt_sharp,
                  text: 'Projetos',
                ),
                GButton(
                  icon: Icons.add,
                  text: 'Adicionar',
                ),
                GButton(
                  icon: Icons.people,
                  text: 'Equipes',
                ),
              ],
              selectedIndex: _selectedIndex, 
              onTabChange: changeScreen,
            ),
        ),
      ),
    );
  }
}
