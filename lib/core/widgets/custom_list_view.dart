import 'package:flutter/material.dart';

import '../../presentation/home/view/widgets/work_item.dart';

class CustomListView extends StatelessWidget {
  final int itemsLength;
  final String title;
  final Icon icon;
  final bool onTap;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  const CustomListView({
    super.key,
    required this.itemsLength,
    required this.title,
    required this.icon,
    required this.itemBuilder,
    this.onTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      child: Column(
        children: [
          MyWorkItemWidget(
            title: title,
            icon: icon,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: itemsLength,
              shrinkWrap: true,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
