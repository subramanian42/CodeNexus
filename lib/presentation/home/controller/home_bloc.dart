import 'package:code_nexus/core/model/repository_info_model.dart';
import 'package:code_nexus/core/model/github_user_model.dart';
import 'package:code_nexus/core/model/organization_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/user_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._userRepository)
      : super(HomeState(user: GithubUserModel.empty, orgs: [], repos: [])) {
    on<FetchUserDetail>(onFetchUserDetail);
  }
  final UserRepository _userRepository;
  void onFetchUserDetail(FetchUserDetail event, Emitter<HomeState> emit) async {
    try {
      final user = await _userRepository.getAuthenticatedUser();
      final organizations = await _userRepository.getOrganization();
      final repositories = await _userRepository.getRepositories();

      emit(
        state.copyWith(
          status: FetchStatus.success,
          user: user,
          orgs: organizations,
          repos: repositories,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }
}
