import 'package:code_nexus/presentation/login/controller/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Success')));
        }
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login Failed with exception ${state.error}')));
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          body: loginPanel(),
        );
      },
    );
  }

  Widget loginPanel() {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * .12),
          Image.asset(
            'assets/github-mark-white.png',
            width: 125,
          ),
          const SizedBox(height: 30),
          Text(
            'Code Nexus',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: height * 1 / 3),
          ElevatedButton(
            style: const ButtonStyle(),
            onPressed: () {
              context.read<LoginBloc>().add(LogInWithGithub());
            },
            child: Text(
              "Sign in With GitHub",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
