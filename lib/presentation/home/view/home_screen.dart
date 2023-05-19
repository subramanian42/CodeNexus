import 'package:code_nexus/core/core.dart';
import 'package:code_nexus/presentation/home/view/widgets/app_bar.dart';
import 'package:code_nexus/presentation/home/view/widgets/organisations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/home_bloc.dart';
import 'widgets/repository.dart';

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
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBarWidget(state: state),
                    RepositoriesWidget(state: state),
                    OrganizationsWidget(state: state),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
