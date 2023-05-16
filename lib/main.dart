import 'package:code_nexus/core/repository/auth_repository.dart';
import 'package:code_nexus/core/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffd2afff), // lilac color using material3
        ),
      ),
      routerConfig: AppRouter.router(context),
    );
  }
}
