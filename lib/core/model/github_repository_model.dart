import 'dart:convert';

class GithubRepositoryModel {
  final int? id;

  final String? name;
  final String? fullName;
  final String? htmlUrl;
  final String? description;
  final String? url;
  final String? branchesUrl;
  final String? contentsUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? pushedAt;

  final String? homepage;
  final int? size;
  final int? stargazersCount;
  final int? watchersCount;
  final String? language;
  final bool? hasIssues;
  final bool? hasProjects;

  final bool? hasPages;

  GithubRepositoryModel({
    this.id,
    this.name,
    this.fullName,
    this.htmlUrl,
    this.description,
    this.url,
    this.branchesUrl,
    this.contentsUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.homepage,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.hasIssues,
    this.hasProjects,
    this.hasPages,
  });

  factory GithubRepositoryModel.fromRawJson(String str) =>
      GithubRepositoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GithubRepositoryModel.fromJson(Map<String, dynamic> json) =>
      GithubRepositoryModel(
        id: json["id"],
        name: json["name"],
        fullName: json["full_name"],
        htmlUrl: json["html_url"],
        description: json["description"],
        url: json["url"],
        branchesUrl: json["branches_url"],
        contentsUrl: json["contents_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pushedAt: json["pushed_at"] == null
            ? null
            : DateTime.parse(json["pushed_at"]),
        homepage: json["homepage"],
        size: json["size"],
        stargazersCount: json["stargazers_count"],
        watchersCount: json["watchers_count"],
        language: json["language"],
        hasIssues: json["has_issues"],
        hasProjects: json["has_projects"],
        hasPages: json["has_pages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "full_name": fullName,
        "html_url": htmlUrl,
        "description": description,
        "url": url,
        "branches_url": branchesUrl,
        "contents_url": contentsUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pushed_at": pushedAt?.toIso8601String(),
        "homepage": homepage,
        "size": size,
        "stargazers_count": stargazersCount,
        "watchers_count": watchersCount,
        "language": language,
        "has_issues": hasIssues,
        "has_projects": hasProjects,
        "has_pages": hasPages,
      };
}
