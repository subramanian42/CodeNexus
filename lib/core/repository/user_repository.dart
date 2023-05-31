import 'package:code_nexus/core/github_client.dart';

import 'package:code_nexus/core/model/repository_detail_model.dart';
import 'package:code_nexus/core/model/repository_info_model.dart';
import 'package:code_nexus/core/model/organization_model.dart';

import '../model/branch_model.dart';
import '../model/folder_details_model.dart';
import '../model/github_user_model.dart';

class UserRepository {
  final GithubClient _githubClient;
  UserRepository(this._githubClient);

  Future<GithubUserModel> getAuthenticatedUser() async {
    final result = await _githubClient.fetch('/user');
    return GithubUserModel.fromJson(result);
  }

  Future<List<OrganizationModel>> getOrganization() async {
    final List<Map<String, dynamic>> result = await _githubClient
        .fetchList('/organizations')
        .then((List<dynamic> value) =>
            value.map((dynamic e) => e as Map<String, dynamic>).toList());

    final List<OrganizationModel> orgsList = <OrganizationModel>[];
    for (Map<String, dynamic> element in result) {
      orgsList.add(OrganizationModel.fromJson(element));
    }
    return orgsList;
  }

  Future<List<RepositoryInfoModel>> getRepositories() async {
    final List<Map<String, dynamic>> result = await _githubClient
        .fetchList('/user/repos')
        .then((List<dynamic> value) =>
            value.map((dynamic e) => e as Map<String, dynamic>).toList());
    final List<RepositoryInfoModel> reposList = <RepositoryInfoModel>[];
    for (Map<String, dynamic> element in result) {
      reposList.add(RepositoryInfoModel.fromJson(element));
    }
    return reposList;
  }

  Future<List<Branch>> getBranches(String url) async {
    final List<Map<String, dynamic>> result = await _githubClient
        .fetchFromUrl(url)
        .then((dynamic value) => (value as List<dynamic>)
            .map((dynamic e) => e as Map<String, dynamic>)
            .toList());
    final List<Branch> branchList = <Branch>[];
    for (Map<String, dynamic> element in result) {
      branchList.add(Branch.fromJson(element));
    }
    return branchList;
  }

  Future<List<RepositoryDetailsModel>> getRepositoryDetails(String url,
      {Map<String, String>? queryParameters}) async {
    final result = await _githubClient
        .fetchFromUrl(url, queryParams: queryParameters)
        .then((dynamic value) => (value as List<dynamic>)
            .map((dynamic e) => e as Map<String, dynamic>)
            .toList());
    final List<RepositoryDetailsModel> githubFilesList =
        <RepositoryDetailsModel>[];
    for (Map<String, dynamic> element in result) {
      githubFilesList.add(RepositoryDetailsModel.fromJson(element));
    }
    return githubFilesList;
  }

  Future<FolderDetailsModel> getFolderDetails(String url,
      {Map<String, String>? queryParameters}) async {
    final Map<String, dynamic> result = await _githubClient.fetchFromUrl(url,
        queryParams: queryParameters) as Map<String, dynamic>;

    final folder = FolderDetailsModel.fromJson(result);
    return folder;
  }
}
