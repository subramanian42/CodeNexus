import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:code_nexus/core/routes/router.dart';
import 'package:code_nexus/core/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/bloc/auth_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            AuthBloc(authenticationRepository: AuthRepository()),
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
      themeMode: ThemeMode.light,
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
