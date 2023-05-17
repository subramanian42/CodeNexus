import 'package:code_nexus/core/model/github_repository_model.dart';
import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:code_nexus/presentation/login/controller/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../presentation/home/controller/home_bloc.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/login/view/login_screen.dart';
import '../../presentation/not_found/view/not_found_screen.dart';
import 'dart:async';

import '../../presentation/repository_detail/repository_detail.dart';
import '../bloc/auth_bloc.dart';
import '../repository/user_repository.dart';

part 'refresh_bloc.dart';

class AppRouter {
  static router(BuildContext ctx) => GoRouter(
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => BlocProvider(
              create: (context) =>
                  HomeBloc(RepositoryProvider.of<UserRepository>(context))
                    ..add(FetchUserDetail()),
              child: const HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: 'detail',
                builder: (context, state) => BlocProvider(
                  create: (context) => RepositoryDetailBloc(
                    currentRepository: state.extra as GithubRepository,
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                  )..add(FetchRepositoryDetail()),
                  child: const RepositoryDetailsScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => BlocProvider(
              create: (context) =>
                  LoginBloc(RepositoryProvider.of<AuthRepository>(context)),
              child: const LoginScreen(),
            ),
          ),
        ],
        redirect: (context, state) {
          final authState = BlocProvider.of<AuthBloc>(context).state;
          final bool loggingIn = state.matchedLocation == '/login' ||
              state.matchedLocation.isEmpty;
          if (authState.status == AppStatus.unauthenticated) {
            return '/login';
          }
          if (loggingIn) {
            return '/';
          }
          return null;
        },
        refreshListenable: GoRouterRefreshBloc<AuthBloc, AuthState>(
          BlocProvider.of<AuthBloc>(ctx),
        ),
        errorBuilder: (context, state) => const NotFoundScreen(),
      );
}
