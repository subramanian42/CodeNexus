import 'package:code_nexus/presentation/repository_detail/repository_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryDetailsScreen extends StatefulWidget {
  const RepositoryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RepositoryDetailsScreen> createState() =>
      _RepositoryDetailsScreenState();
}

class _RepositoryDetailsScreenState extends State<RepositoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text(context.watch<RepositoryDetailBloc>().state.status.toString()),
      ),
    );
  }
}
