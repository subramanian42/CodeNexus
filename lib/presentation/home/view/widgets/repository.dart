// Stateless widget that represents the repositories container
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/file_tile.dart';
import '../../controller/home_bloc.dart';
import 'work_item.dart';

class RepositoriesWidget extends StatelessWidget {
  final HomeState state;

  const RepositoriesWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.only(top: 10),
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          const MyWorkItemWidget(
            title: "Repositories",
            icon: Icon(
              Icons.insert_invitation,
              color: Colors.purple,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.repos.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final repo = state.repos[index];
                return FileTile(
                  onTap: () => context.push('/repository', extra: repo),
                  isFolder: true,
                  title: repo.name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
