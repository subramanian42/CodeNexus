// Stateless widget that represents the follow count
import 'package:flutter/material.dart';

import '../../controller/home_bloc.dart';

class FollowCountWidget extends StatelessWidget {
  final HomeState state;

  const FollowCountWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Followers:  ${state.user.followers}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Following:  ${state.user.following}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
