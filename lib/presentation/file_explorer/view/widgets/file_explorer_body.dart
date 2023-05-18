import 'package:code_nexus/core/model/folder_details_model.dart';
import 'package:code_nexus/core/widgets/file_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FileExplorerBody extends StatelessWidget {
  const FileExplorerBody({required this.folderDetails, super.key});
  final FolderDetailsModel folderDetails;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: folderDetails.tree?.length,
      itemBuilder: (context, index) {
        final selfUrl = folderDetails.url;
        final folderDetailsTree = folderDetails.tree![index];

        return FileTile(
          onTap: folderDetailsTree.type == "tree"
              ? () => context.pushNamed(
                    'file_explorer',
                    pathParameters: {
                      "name": folderDetailsTree.path ?? "",
                    },
                    extra: {
                      "self": selfUrl ?? "",
                      "next": folderDetailsTree.url ?? "",
                    },
                  )
              : null,
          isFolder: folderDetailsTree.type == "tree",
          title: folderDetailsTree.path,
        );
      },
    );
  }
}
