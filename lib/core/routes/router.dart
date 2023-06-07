import 'package:code_nexus/core/model/repository_info_model.dart';
import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:code_nexus/presentation/login/controller/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../presentation/file_explorer/file_explorer.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/login/view/login_screen.dart';
import '../../presentation/not_found/view/not_found_screen.dart';
import 'dart:async';

import '../../presentation/repository_detail/repository_detail.dart';
import '../bloc/auth_bloc.dart';
import '../repository/user_repository.dart';

part 'router_refresh_bloc.dart';

class AppRouter {
  static GoRouter router(BuildContext ctx) {
    return GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshBloc<AuthBloc, AuthState>(
        BlocProvider.of<AuthBloc>(ctx),
      ),
      redirect: (context, state) {
        final authState = BlocProvider.of<AuthBloc>(context).state;
        final bool loggingIn =
            state.matchedLocation == LoginScreen.routeName || state.matchedLocation.isEmpty;
        if (authState.status == AppStatus.unauthenticated) {
          return LoginScreen.routeName;
        }
        if (loggingIn) {
          return '/';
        }
        return null;
      },
      errorBuilder: (context, state) => const NotFoundScreen(),
      routes: [
        GoRoute(
          path: '/',
          builder: HomeScreen.routeBuilder,
          routes: [
            GoRoute(
              path: 'repository',
              builder: (context, state) => BlocProvider(
                create: (context) => RepositoryDetailBloc(
                  currentRepository: state.extra as RepositoryInfoModel,
                  userRepository: context.read<UserRepository>(),
                )..add(FetchRepositoryDetail()),
                child: const RepositoryDetailsScreen(),
              ),
              routes: [
                GoRoute(
                  path: '${FileExplorerScreen.routeName}/:name',
                  name: FileExplorerScreen.routeName,
                  builder: FileExplorerScreen.routeBuilder,
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: LoginScreen.routeName,
          builder: (context, state) => BlocProvider(
            create: (context) => LoginBloc(RepositoryProvider.of<AuthRepository>(context)),
            child: const LoginScreen(),
          ),
        ),
      ],
    );
  }
}
