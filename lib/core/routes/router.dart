import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:code_nexus/presentation/login/controller/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import '../../presentation/home/view/home_screen.dart';
import '../../presentation/login/view/login_screen.dart';
import '../../presentation/not_found/view/not_found_screen.dart';
import 'dart:async';

import '../bloc/auth_bloc.dart';

part 'refresh_stream.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static router(BuildContext context) => GoRouter(
        navigatorKey: _rootNavigatorKey,
        routes: [
          GoRoute(
            path: '/home',
            name: 'HomeScreen',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/login',
            name: 'LoginScreen',
            builder: (context, state) => BlocProvider(
              create: (context) =>
                  LoginBloc(RepositoryProvider.of<AuthRepository>(context)),
              child: const LoginScreen(),
            ),
          ),
        ],
        redirect: ((context, state) {
          final authState = BlocProvider.of<AuthBloc>(context).state;
          if (authState is AuthSuccess) {
            return '/home';
          } else if (authState is AuthInitial) {
            return '/login';
          }
          return null;
        }),
        refreshListenable:
            GoRouterRefreshStream(context.read<AuthBloc>().stream),
        errorBuilder: (context, state) => const NotFoundScreen(),
      );
}
