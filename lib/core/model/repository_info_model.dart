import 'dart:convert';

class RepositoryInfoModel {
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

  RepositoryInfoModel({
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

  factory RepositoryInfoModel.fromRawJson(String str) =>
      RepositoryInfoModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RepositoryInfoModel.fromJson(Map<String, dynamic> json) =>
      RepositoryInfoModel(
        id: json["id"] as int?,
        name: json["name"] as String?,
        fullName: json["full_name"] as String?,
        htmlUrl: json["html_url"] as String?,
        description: json["description"] as String?,
        url: json["url"] as String?,
        branchesUrl: json["branches_url"] as String?,
        contentsUrl: json["contents_url"] as String?,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse((json["created_at"] as String?) ?? ""),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse((json["updated_at"] as String?) ?? ""),
        pushedAt: json["pushed_at"] == null
            ? null
            : DateTime.parse((json["pushed_at"] as String?) ?? ""),
        homepage: json["homepage"] as String?,
        size: json["size"] as int?,
        stargazersCount: json["stargazers_count"] as int?,
        watchersCount: json["watchers_count"] as int?,
        language: json["language"] as String?,
        hasIssues: json["has_issues"] as bool?,
        hasProjects: json["has_projects"] as bool?,
        hasPages: json["has_pages"] as bool?,
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
