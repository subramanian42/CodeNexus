import 'package:code_nexus/core/model/repository_detail_model.dart';
import 'package:code_nexus/core/model/repository_info_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/branch_model.dart';
import '../../../../core/repository/user_repository.dart';

part 'repository_detail_event.dart';
part 'repository_detail_state.dart';

class RepositoryDetailBloc
    extends Bloc<RepositoryDetailEvent, RepositoryDetailState> {
  RepositoryInfoModel currentRepository;
  UserRepository userRepository;
  RepositoryDetailBloc(
      {required this.currentRepository, required this.userRepository})
      : super(const RepositoryDetailState()) {
    on<FetchRepositoryDetail>(onFetchRepositoryDetail);
  }
  void onFetchRepositoryDetail(
      RepositoryDetailEvent event, Emitter<RepositoryDetailState> emit) async {
    try {
      String? branchUrl =
          currentRepository.branchesUrl?.replaceAll("{/branch}", "");
      final branches = await userRepository.getBranches(branchUrl ?? "");
      final fileContentBranchMap = await _fetchBranchContents(branches);
      emit(
        state.copyWith(
          status: FetchStatus.success,
          branches: branches,
          fileContentBranchMap: fileContentBranchMap,
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

  Future<Map<String, List<RepositoryDetailsModel>>> _fetchBranchContents(
      List<Branch> branches) async {
    String? contentUrl =
        currentRepository.contentsUrl?.replaceAll("{+path}", "");
    Map<String, List<RepositoryDetailsModel>> branchContent = {};
    for (int i = 0; i < branches.length; i++) {
      if (branches[i].name != null) {
        final repositoryDetails = await userRepository
            .getRepositoryDetails(contentUrl ?? "", queryParameters: {
          "ref": branches[i].name!,
        });
        branchContent[branches[i].name!] = repositoryDetails;
      }
    }
    return branchContent;
  }
}
