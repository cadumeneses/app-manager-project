import 'package:flutter/material.dart';

class BottomNavigatorComponent extends StatelessWidget {
  const BottomNavigatorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_sharp),
          label: "Projetos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'add'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Equipes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Perfil",
        ),
      ],
    );
  }
}