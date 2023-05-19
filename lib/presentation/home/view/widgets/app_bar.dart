import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/auth_bloc.dart';
import '../../controller/home_bloc.dart';
import 'bio.dart';
import 'follower_count.dart';

// Stateful widget that represents the app bar
class AppBarWidget extends StatelessWidget {
  final HomeState state;

  const AppBarWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height / 20,
      flexibleSpace: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(AppLogoutRequested()),
                  icon: const RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.exit_to_app_rounded,
                      size: 30,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
                Text(
                  "Hi ${state.user.name?.trim()}!",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                AvatarWidget(state: state),
              ],
            ),
            const SizedBox(height: 16),
            BioWidget(state: state),
            FollowCountWidget(state: state),
          ],
        ),
      ),
    );
  }
}

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
