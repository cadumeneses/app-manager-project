import 'package:app_manager_project/components/profile_form_component.dart';
import 'package:app_manager_project/utils/app_routes.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/person.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/brisa_logo1.png',
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Perfil",
                    style: TextStyle(
                        fontFamily: "Barlow",
                        color: CustomColor.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  minRadius: 35,
                  maxRadius: 50,
                  child: Image.asset(
                    'assets/images/sorriso 1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 25),
                  child: Text(
                    'Monkey D. Luffy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        '27',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Projetos',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      )
                    ],
                  ),
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  Column(
                    children: [
                      const Text(
                        '189',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tarefas',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      )
                    ],
                  ),
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  Column(
                    children: [
                      const Text(
                        '4',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Equipes',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar Perfil'),
              onTap: () {
                showModalForm(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text('Mudar tema'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ajuda'),
              onTap: () {},
            ),
            ListTile(
              iconColor: Colors.red,
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => showModal(context),
            ),
          ],
        ),
      ),
    );
  }
}

void showModalForm(BuildContext context) {
  showBottomSheet(
      context: context,
      builder: (_) {
        return const ProfileFormComponent();
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))));
}

void showModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return const LogoutModal();
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))));
}

class LogoutModal extends StatelessWidget {
  const LogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_down,
                size: 40, color: Colors.grey.shade400),
          ),
          const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          const Text(
            'Tem certeza que quer sair?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.auth_or_home);
              },
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Center(
                  child: Text(
                    'Sim, quero sair',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColor.backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Center(
                child: Text(
                  'Cancelar',
                  style:
                      TextStyle(fontSize: 18, color: CustomColor.primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
