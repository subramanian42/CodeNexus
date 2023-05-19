import 'package:flutter/material.dart';

import '../../../../core/widgets/file_tile.dart';
import '../../home.dart';
import 'work_item.dart';

class OrganizationsWidget extends StatelessWidget {
  final HomeState state;

  const OrganizationsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
          const MyWorkItemWidget(
            title: "Organizations",
            icon: Icon(
              Icons.people_outline,
              color: Colors.purple,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: state.orgs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final org = state.orgs[index];
                return FileTile(
                  onTap: null,
                  isFolder: true,
                  title: org.login,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
