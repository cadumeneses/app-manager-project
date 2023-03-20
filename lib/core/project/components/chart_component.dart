import 'package:flutter/material.dart';

import '../../utils/custom_color.dart';

class ChartComponent extends StatelessWidget {
  const ChartComponent({required this.percentage, super.key});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              width: constraints.maxWidth * 1,
              height: 8,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),   
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}