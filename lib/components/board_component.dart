import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board.dart';

class BoardComponent extends StatelessWidget {
  const BoardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<Board>(context, listen: false);
    return SingleChildScrollView(
      child: Card(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Text(board.name),
                CircleAvatar(
                  child: Text('0'),
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ]),
        ]),
      ),
    );
  }
}
