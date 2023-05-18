import 'package:code_nexus/core/model/folder_details_model.dart';
import 'package:code_nexus/presentation/file_explorer/view/widgets/file_explorer_body.dart';
import 'package:flutter/material.dart';

import 'empty_body.dart';

class FileListView extends StatelessWidget {
  const FileListView({required this.folderDetails, super.key});
  final FolderDetailsModel folderDetails;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFF2F5F8),
        child: switch (folderDetails.tree?.isEmpty ?? true) {
          true => const EmptyBody(),
          false => FileExplorerBody(
              folderDetails: folderDetails,
            ),
        });
  }
}
