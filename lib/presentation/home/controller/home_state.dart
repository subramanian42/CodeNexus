part of 'home_bloc.dart';

enum FetchStatus { initial, success, failure }

class HomeState {
  final FetchStatus status;
  final GithubUserModel user;
  final List<OrganizationModel> orgs;
  final List<GithubRepositoryModel> repos;
  final String? errorMessage;
  const HomeState({
    this.status = FetchStatus.initial,
    required this.user,
    required this.orgs,
    required this.repos,
    this.errorMessage,
  });
  HomeState copyWith({
    FetchStatus? status,
    GithubUserModel? user,
    List<OrganizationModel>? orgs,
    List<GithubRepositoryModel>? repos,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      orgs: orgs ?? this.orgs,
      repos: repos ?? this.repos,
      errorMessage: errorMessage,
    );
  }
}
