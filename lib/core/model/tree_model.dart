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

  factory Tree.fromRawJson(String str) =>
      Tree.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        path: json["path"] as String?,
        mode: json["mode"] as String?,
        type: json["type"] as String?,
        sha: json["sha"] as String?,
        url: json["url"] as String?,
        size: json["size"] as int?,
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
