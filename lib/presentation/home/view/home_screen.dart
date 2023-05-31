import 'package:code_nexus/core/core.dart';
import 'package:code_nexus/core/widgets/custom_list_view.dart';
import 'package:code_nexus/presentation/home/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controller/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchStatus.initial:
            return const LoadingScreen();
          case (FetchStatus.failure):
            return ErrorScreen(
              errorMessage: state.errorMessage,
              onPressed: () => context.read<HomeBloc>().add(FetchUserDetail()),
            );
          case FetchStatus.success:
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBarWidget(state: state),
                      _buildRepositoriesWidget(state),
                      _buildOrganisationWidget(state),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }

  Widget _buildRepositoriesWidget(HomeState state) {
    return CustomListView(
      itemsLength: state.repos.length,
      title: "Repositories",
      icon: Icon(
        Icons.insert_invitation,
        color: Colors.purple,
      ),
      itemBuilder: (BuildContext context, int index) {
        final repo = state.repos[index];
        return FileTile(
          onTap: () => context.push('/repository', extra: repo),
          isFolder: true,
          title: repo.name,
        );
      },
    );
  }

  Widget _buildOrganisationWidget(HomeState state) {
    return CustomListView(
      itemsLength: state.orgs.length,
      title: "Organizations",
      icon: Icon(
        Icons.people_outline,
        color: Colors.purple,
      ),
      itemBuilder: (BuildContext context, int index) {
        final org = state.orgs[index];
        return FileTile(
          onTap: null,
          isFolder: true,
          title: org.login,
        );
      },
    );
  }
}
