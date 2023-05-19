import 'package:flutter/material.dart';

import '../../controller/home_bloc.dart';

// Stateless widget that represents the bio
class BioWidget extends StatelessWidget {
  final HomeState state;

  const BioWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bio',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            state.user.bio ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
