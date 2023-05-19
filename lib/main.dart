import 'package:code_nexus/core/github_client.dart';
import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:code_nexus/core/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/bloc/auth_bloc.dart';
import 'core/repository/user_repository.dart';
import 'core/theme/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const CodeNexus());
}

class CodeNexus extends StatefulWidget {
  const CodeNexus({super.key});

  @override
  State<CodeNexus> createState() => _CodeNexusState();
}

class _CodeNexusState extends State<CodeNexus> {
  final _client = GithubClient();
  final _authRepo = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => _authRepo),
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(_client)),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(authenticationRepository: _authRepo),
        child: const CodeNexusView(),
      ),
    );
  }
}

class CodeNexusView extends StatefulWidget {
  const CodeNexusView({super.key});

  @override
  State<CodeNexusView> createState() => _CodeNexusViewState();
}

class _CodeNexusViewState extends State<CodeNexusView> {
  late final GoRouter _router;
  @override
  void initState() {
    super.initState();
    _router = AppRouter.router(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: AppTheme.darkColorScheme,
      ),
      themeMode: ThemeMode.dark,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: AppTheme.lightColorScheme,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
