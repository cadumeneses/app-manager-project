import 'package:flutter/material.dart';

class HeadingWithAction extends StatelessWidget {
  final String headingText;
  final String actionText;
  final VoidCallback onActionPressed;

  const HeadingWithAction({
    Key? key,
    required this.headingText,
    required this.actionText,
    required this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingText,
            style: textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionText,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.primaryContainer,
              ),
            ),
          )
        ],
      ),
    );
  }
}
