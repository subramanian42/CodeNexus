import 'package:flutter/material.dart';

import '../../controller/home_bloc.dart';

// Stateless widget that represents the avatar
class AvatarWidget extends StatelessWidget {
  final HomeState state;

  const AvatarWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final image = state.user.avatarUrl != null
        ? NetworkImage(state.user.avatarUrl ?? "")
        : const AssetImage("assets/github-mark.png") as ImageProvider;
    return CircleAvatar(
      backgroundImage: image,
      radius: 25,
      backgroundColor: Colors.transparent,
    );
  }
}
