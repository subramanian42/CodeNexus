// Stateless widget that represents the list item in my work items
import 'package:flutter/material.dart';

class MyWorkItemWidget extends StatelessWidget {
  final String title;
  final Icon icon;

  const MyWorkItemWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.all(4.0),
        child: icon,
      ),
      title: Text(
        title,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
