part of 'folder_details_model.dart';

class Tree {
  final String? path;
  final String? mode;
  final String? type;
  final String? sha;
  final String? url;
  final int? size;

  Tree({
    this.path,
    this.mode,
    this.type,
    this.sha,
    this.url,
    this.size,
  });

  factory Tree.fromRawJson(String str) => Tree.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        path: json["path"],
        mode: json["mode"],
        type: json["type"],
        sha: json["sha"],
        url: json["url"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "mode": mode,
        "type": type,
        "sha": sha,
        "url": url,
        "size": size,
      };
}
