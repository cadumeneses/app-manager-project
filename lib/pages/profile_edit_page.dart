import 'package:app_manager_project/components/form/input_text_form.dart';
import 'package:app_manager_project/components/profile_form_component.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';


class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomColor.backgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    "Editar Perfil",
                    style: TextStyle(
                        fontFamily: "Barlow",
                        color: CustomColor.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
              CircleAvatar(
                minRadius: 35,
                maxRadius: 50,
                child: Image.asset(
                  'assets/images/sorriso 1.png',
                  fit: BoxFit.cover,
                ),
              ),
              const ProfileFormComponent()
            ],
          ),
        ),
    );
  }
}
