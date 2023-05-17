import 'package:code_nexus/core/model/github_repository_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/model/branch_model.dart';
import '../../../core/repository/user_repository.dart';
part 'repository_detail_event.dart';
part 'repository_detail_state.dart';

class RepositoryDetailBloc
    extends Bloc<RepositoryDetailEvent, RepositoryDetailState> {
  GithubRepositoryModel currentRepository;
  UserRepository userRepository;
  RepositoryDetailBloc(
      {required this.currentRepository, required this.userRepository})
      : super(const RepositoryDetailState()) {
    on<FetchRepositoryDetail>(onFetchRepositoryDetail);
  }
  void onFetchRepositoryDetail(
      RepositoryDetailEvent event, Emitter<RepositoryDetailState> emit) async {
    try {
      String? url = currentRepository.branchesUrl?.replaceAll("{/branch}", "");
      // url = url?.replaceFirst("https://", "");
      final branches = await userRepository.getBranches(url ?? "");
      emit(
        state.copyWith(
          status: FetchStatus.success,
          branches: branches,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FetchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
