import 'dart:convert';

class RepositoryDetailsModel {
  final String? name;
  final String? path;
  final String? sha;
  final int? size;
  final String? url;
  final String? htmlUrl;
  final String? gitUrl;
  final dynamic downloadUrl;
  final String? type;

  RepositoryDetailsModel({
    this.name,
    this.path,
    this.sha,
    this.size,
    this.url,
    this.htmlUrl,
    this.gitUrl,
    this.downloadUrl,
    this.type,
  });

  factory RepositoryDetailsModel.fromRawJson(String str) =>
      RepositoryDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RepositoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      RepositoryDetailsModel(
        name: json["name"],
        path: json["path"],
        sha: json["sha"],
        size: json["size"],
        url: json["url"],
        htmlUrl: json["html_url"],
        gitUrl: json["git_url"],
        downloadUrl: json["download_url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
        "sha": sha,
        "size": size,
        "url": url,
        "html_url": htmlUrl,
        "git_url": gitUrl,
        "download_url": downloadUrl,
        "type": type,
      };
}
