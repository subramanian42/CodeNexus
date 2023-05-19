import 'package:code_nexus/core/widgets/file_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/model/repository_detail_model.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({required this.title, required this.branchfiles, super.key});
  final String title;
  final List<RepositoryDetailsModel> branchfiles;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: branchfiles.length,
      itemBuilder: (context, index) {
        final branchfile = branchfiles[index];

        return FileTile(
          onTap: branchfile.type == "dir"
              ? () => context.pushNamed(
                    'file_explorer',
                    pathParameters: {
                      "name": branchfile.name ?? "",
                    },
                    extra: {
                      "self": branchfile.url ?? "",
                      "next": branchfile.gitUrl ?? "",
                    },
                  )
              : null,
          isFolder: branchfile.type == "dir",
          title: branchfile.name,
        );
      },
    );
  }
}
