import 'package:app_manager_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MenuNavigation extends StatefulWidget {
  const MenuNavigation({super.key});

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
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
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
              if (_selectedIndex == 1) {
                Navigator.of(context).pushNamed(AppRoutes.projects);
              } else {
                Navigator.of(context).pushNamed(AppRoutes.home);
              }
            });
          },
        ),
      ),
    );
  }
}
