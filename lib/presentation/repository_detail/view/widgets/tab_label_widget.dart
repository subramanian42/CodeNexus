import 'package:flutter/material.dart';

class TabLabelWidget extends StatelessWidget {
  const TabLabelWidget({
    required this.label,
    super.key,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(label),
    );
  }
}
