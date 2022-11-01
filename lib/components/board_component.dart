import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_manager_project/utils/custom_color.dart';
import '../models/board.dart';

class BoardComponent extends StatelessWidget {
  const BoardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<Board>(context, listen: false);
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          color: CustomColor.backgroundColor,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          board.name,
                          style: const TextStyle(
                            color: CustomColor.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const CircleAvatar(
                          maxRadius: 22,
                          backgroundColor: CustomColor.secondaryColor,
                          child: CircleAvatar(
                            backgroundColor: CustomColor.whiteColor,
                            foregroundColor: CustomColor.secondaryColor,
                            maxRadius: 20,
                            child: Text('0'),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.squarePlus,
                          color: CustomColor.primaryColor,
                        ))
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
