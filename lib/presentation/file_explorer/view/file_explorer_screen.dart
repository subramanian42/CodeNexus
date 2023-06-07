import 'package:code_nexus/core/model/repository_detail_model.dart';
import 'package:code_nexus/core/widgets/loading_screen.dart';
import 'package:code_nexus/presentation/file_explorer/view/widgets/file_explorer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/user_repository.dart';
import '../../../core/widgets/error_screen.dart';
import '../controller/file_explorer_bloc.dart';
import 'package:go_router/go_router.dart';

class FileExplorerScreen extends StatefulWidget {
  const FileExplorerScreen._({Key? key}) : super(key: key);

  static String routeName = 'file_explorer';

  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    FileExplorerParams params;
    if (state.extra != null) {
      params = state.extra as FileExplorerParams;
    } else {
      params = FileExplorerParams.fromMap(state.queryParameters);
    }
    return BlocProvider(
      create: (context) => FileExplorerBloc(
        params: params,
        userRepository: context.read<UserRepository>(),
      )..add(FetchFolderDetails()),
      child: const FileExplorerScreen._(),
    );
  }

  static void navigateTo(BuildContext context, RepositoryDetailsModel file) {
    context.pushNamed(
      routeName,
      extra: FileExplorerParams(
        name: file.name,
        self: file.url,
        next: file.gitUrl,
      ),
    );
  }

  static Uri buildDeepLink(Uri base, FileExplorerParams params) {
    return base.replace(
      path: '/${routeName}',
      queryParameters: params.toMap(),
    );
  }

  @override
  State<FileExplorerScreen> createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> {
  late final String filename;

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<FileExplorerBloc>(context);
    filename = bloc.params.name;
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
              FetchStatus.success => FileExplorerBody(folderDetails: state.folderDetails),
              FetchStatus.initial => const LoadingScreen(),
              FetchStatus.failure => ErrorScreen(
                  errorMessage: state.errorMessage,
                  onPressed: () => context.read<FileExplorerBloc>().add(FetchFolderDetails()),
                ),
            },
          ),
        );
      },
    );
  }
}
