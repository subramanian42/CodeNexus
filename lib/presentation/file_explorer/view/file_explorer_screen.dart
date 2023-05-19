import 'package:code_nexus/core/widgets/loading_screen.dart';
import 'package:code_nexus/presentation/file_explorer/view/widgets/file_explorer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/error_screen.dart';
import '../controller/file_explorer_bloc.dart';

class FileExplorerScreen extends StatefulWidget {
  const FileExplorerScreen({Key? key}) : super(key: key);

  @override
  State<FileExplorerScreen> createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> {
  late final String filename;
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<FileExplorerBloc>(context);
    filename = bloc.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileExplorerBloc, FileExplorerState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.folder_open,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        filename,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            body: switch (state.status) {
              FetchStatus.success =>
                FileExplorerBody(folderDetails: state.folderDetails),
              FetchStatus.initial => const LoadingScreen(),
              FetchStatus.failure => ErrorScreen(
                  errorMessage: state.errorMessage,
                  onPressed: () => context
                      .read<FileExplorerBloc>()
                      .add(FetchFolderDetails()),
                ),
            },
          ),
        );
      },
    );
  }
}
