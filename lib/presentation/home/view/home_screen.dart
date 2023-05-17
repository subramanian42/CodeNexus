import 'package:code_nexus/core/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../controller/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchStatus.initial:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case (FetchStatus.failure):
            return const Scaffold(
              body: Center(
                child: Text('failed to fetch user'),
              ),
            );
          case FetchStatus.success:
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    appBar(state),
                    organizations(state),
                    repostiories(state),
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  Widget appBar(HomeState state) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 16),
      color: Theme.of(context).colorScheme.primary,
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
                    color: Colors.white,
                    size: 30,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              Text(
                "Hi ${state.user.name?.trim()}!",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              avatar(state),
            ],
          ),
          const SizedBox(height: 16),
          bio(state),
          followCount(state),
        ],
      ),
    );
  }

  Widget avatar(HomeState state) {
    final image = state.user.avatarUrl != null
        ? NetworkImage(state.user.avatarUrl ?? "")
        : const AssetImage("assets/github-mark.png") as ImageProvider;
    return CircleAvatar(
      backgroundImage: image,
      radius: 25,
      backgroundColor: Colors.transparent,
    );
  }

  Widget bio(HomeState state) {
    return Column(
      children: [
        Text(
          'Bio',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(state.user.bio ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)),
        ),
      ],
    );
  }

  Widget followCount(HomeState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Followers:  ${state.user.followers}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          Text(
            'Following:  ${state.user.following}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget organizations(HomeState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.only(bottom: 16),
      constraints: const BoxConstraints(
        maxHeight: 350,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Column(
        children: [
          _myWorkItem(
              "Organizations",
              const Icon(
                Icons.people_outline,
                color: Colors.white,
              ),
              Colors.orange),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: state.orgs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final org = state.orgs[index];
                return Container(
                  constraints: const BoxConstraints(maxHeight: 75),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: org.avatarUrl != null
                          ? NetworkImage(org.avatarUrl ?? "")
                          : const AssetImage("assets/github-mark.png")
                              as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(
                      org.login ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: org.description?.isNotEmpty ?? false
                        ? Text(
                            org.description ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget repostiories(HomeState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      constraints: const BoxConstraints(
        maxHeight: 350,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Column(
        children: [
          _myWorkItem(
              "Repositories",
              const Icon(
                Icons.insert_invitation,
                color: Colors.white,
              ),
              Colors.purple),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: state.repos.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final repo = state.repos[index];
                return Container(
                  constraints: const BoxConstraints(maxHeight: 75),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    title: Text(
                      repo.name ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: repo.description?.isNotEmpty ?? false
                        ? Text(
                            repo.description ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        : null,
                    onTap: () {
                      context.push('/detail', extra: repo);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _myWorkItem(String title, Icon icon, Color color) {
    return (ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4.0),
            color: color,
          ),
          padding: const EdgeInsets.all(4.0),
          child: icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 25),
      ),
    ));
  }
}
