import 'dart:convert';

class RepositoryDetailsModel {
  final String name;
  final String path;
  final String sha;
  final int? size;
  final String url;
  final String htmlUrl;
  final String gitUrl;

  final String type;

  RepositoryDetailsModel({
    required this.name,
    required this.path,
    required this.sha,
    this.size,
    required this.url,
    required this.htmlUrl,
    required this.gitUrl,
    required this.type,
  });

  factory RepositoryDetailsModel.fromRawJson(String str) =>
      RepositoryDetailsModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory RepositoryDetailsModel.fromJson(Map<String, dynamic> json) => RepositoryDetailsModel(
        name: json["name"] as String? ?? '',
        path: json["path"] as String? ?? '',
        sha: json["sha"] as String? ?? '',
        size: json["size"] as int?,
        url: json["url"] as String? ?? '',
        htmlUrl: json["html_url"] as String? ?? '',
        gitUrl: json["git_url"] as String? ?? '',
        type: json["type"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "sha": sha,
        "size": size,
        "url": url,
        "html_url": htmlUrl,
        "git_url": gitUrl,
        "type": type,
      };
}
