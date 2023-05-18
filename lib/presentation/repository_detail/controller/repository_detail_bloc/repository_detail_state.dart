part of 'repository_detail_bloc.dart';

enum FetchStatus { initial, success, failure }

class RepositoryDetailState {
  final FetchStatus status;
  final List<Branch> branches;
  final Map<String, List<RepositoryDetailsModel>> fileContentBranchMap;

  final String? errorMessage;
  const RepositoryDetailState({
    this.status = FetchStatus.initial,
    this.branches = const [],
    this.errorMessage,
    this.fileContentBranchMap = const {},
  });
  RepositoryDetailState copyWith({
    FetchStatus? status,
    List<Branch>? branches,
    List<RepositoryInfoModel>? repos,
    Map<String, List<RepositoryDetailsModel>>? fileContentBranchMap,
    String? errorMessage,
  }) {
    return RepositoryDetailState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      fileContentBranchMap: fileContentBranchMap ?? this.fileContentBranchMap,
      errorMessage: errorMessage,
    );
  }
}
