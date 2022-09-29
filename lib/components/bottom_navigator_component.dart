import 'package:app_manager_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
            });
          },
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> buildBottomNavBarItems() {
  return const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Red',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Blue',
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'Yellow'
    )
  ];
}


class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: buildBottomNavBarItems(),

    );
  }
}
