part of 'repository_detail_bloc.dart';

enum FetchStatus { initial, success, failure }

class RepositoryDetailState {
  final FetchStatus status;
  final List<Branch> branches;

  final String? errorMessage;
  const RepositoryDetailState({
    this.status = FetchStatus.initial,
    this.branches = const [],
    this.errorMessage,
  });
  RepositoryDetailState copyWith({
    FetchStatus? status,
    List<Branch>? branches,
    List<GithubRepositoryModel>? repos,
    String? errorMessage,
  }) {
    return RepositoryDetailState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      errorMessage: errorMessage,
    );
  }
}
