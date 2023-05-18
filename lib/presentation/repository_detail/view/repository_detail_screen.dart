import 'package:code_nexus/core/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/loading_screen.dart';
import '../controller/controller.dart';
import 'widgets/widgets.dart';

class RepositoryDetailsScreen extends StatefulWidget {
  const RepositoryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RepositoryDetailsScreen> createState() =>
      _RepositoryDetailsScreenState();
}

class _RepositoryDetailsScreenState extends State<RepositoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryDetailBloc, RepositoryDetailState>(
      builder: (context, state) {
        return switch (state.status) {
          FetchStatus.success => _repositoryDetailBody(),
          FetchStatus.initial => const LoadingScreen(),
          FetchStatus.failure => ErrorScreen(
              errorMessage: state.errorMessage,
              onPressed: () => context
                  .read<RepositoryDetailBloc>()
                  .add(FetchRepositoryDetail()),
            ),
        };
      },
    );
  }

  Widget _repositoryDetailBody() {
    return BlocProvider(
      create: (context) => TabBarCubit(),
      child: const RepositoryDetailBody(),
    );
  }
}
