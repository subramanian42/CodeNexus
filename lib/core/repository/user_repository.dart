import 'package:code_nexus/core/github_client.dart';
import 'package:code_nexus/core/model/github_repository_model.dart';
import 'package:code_nexus/core/model/organization_model.dart';

import '../model/branch_model.dart';
import '../model/github_user_model.dart';

class UserRepository {
  final GithubClient _githubClient;
  UserRepository(this._githubClient);

  Future<GithubUserModel> getAuthenticatedUser() async {
    final result = await _githubClient.fetch('/user');
    return GithubUserModel.fromJson(result);
  }

  Future<List<OrganizationModel>> getOrganization() async {
    final result = await _githubClient.fetchList('/organizations');
    final List<OrganizationModel> orgsList = <OrganizationModel>[];
    for (dynamic element in result) {
      orgsList.add(OrganizationModel.fromJson(element));
    }
    return orgsList;
  }

  Future<List<GithubRepositoryModel>> getRepositories() async {
    final result = await _githubClient.fetchList('/user/repos');
    final List<GithubRepositoryModel> reposList = <GithubRepositoryModel>[];
    for (dynamic element in result) {
      reposList.add(GithubRepositoryModel.fromJson(element));
    }
    return reposList;
  }

  Future<List<Branch>> getBranches(String url) async {
    final result = await _githubClient.fetchFromUrl(url);
    final List<Branch> branchList = <Branch>[];
    for (dynamic element in result) {
      branchList.add(Branch.fromJson(element));
    }
    return branchList;
  }
}
