import 'package:code_nexus/presentation/repository_detail/view/widgets/tab_label_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/repository_detail_bloc/repository_detail_bloc.dart';

import '../../controller/tab_bar_cubit/tab_bar_cubit.dart';
import 'tab_widget.dart';

class RepositoryDetailBody extends StatefulWidget {
  const RepositoryDetailBody({super.key});

  @override
  State<RepositoryDetailBody> createState() => _RepositoryDetailBodyState();
}

class _RepositoryDetailBodyState extends State<RepositoryDetailBody>
    with SingleTickerProviderStateMixin {
  late final List<Widget> tabs;
  late final RepositoryDetailBloc _bloc;
  late final TabController _tabController;
  late final List<Widget> tabLables;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<RepositoryDetailBloc>(context);
    int length = _bloc.state.branches.length;
    _tabController = TabController(length: length, vsync: this);
    tabLables = createTabslabels(_bloc.state);
    tabs = createTabs(_bloc.state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabBarCubit, int>(
      listener: (context, state) => _tabController.index = state,
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _appBar(),
            body: TabBarView(
              controller: _tabController,
              children: tabs,
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar() {
    final title = _bloc.currentRepository.name;
    final description = _bloc.currentRepository.description;
    return AppBar(
      toolbarHeight: description != null ? 120 : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title ?? "title is empty",
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          if (description != null) ...{
            const SizedBox(height: 8),
            Text(
              description,
              maxLines: 4,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          }
        ],
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: tabLables,
        onTap: (value) {
          context.read<TabBarCubit>().updateIndex(value);
        },
      ),
    );
  }

  List<Widget> createTabslabels(RepositoryDetailState state) {
    List<Widget> tabLables = [];

    for (var element in state.branches) {
      tabLables.add(TabLabelWidget(label: element.name ?? "empty"));
    }
    return tabLables;
  }

  List<Widget> createTabs(RepositoryDetailState state) {
    List<Widget> customTabs = [];
    for (var element in state.fileContentBranchMap.entries) {
      customTabs.add(
        CustomTab(title: element.key, branchfiles: element.value),
      );
    }

    return customTabs;
  }
}
