import 'dart:convert';

part "tree_model.dart";

class FolderDetailsModel {
  final String? sha;
  final String? url;
  final List<Tree>? tree;
  final bool? truncated;

  const FolderDetailsModel({
    this.sha,
    this.url,
    this.tree,
    this.truncated,
  });

  factory FolderDetailsModel.fromRawJson(String str) =>
      FolderDetailsModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory FolderDetailsModel.fromJson(Map<String, dynamic> json) =>
      FolderDetailsModel(
        sha: json["sha"] as String?,
        url: json["url"] as String?,
        tree: json["tree"] == null
            ? []
            : List<Tree>.from((json["tree"] as List<Map<String, dynamic>>?)!
                .map((x) => Tree.fromJson(x))),
        truncated: json["truncated"] as bool?,
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
        "tree": tree == null
            ? null
            : List<dynamic>.from(tree!.map((x) => x.toJson())),
        "truncated": truncated,
      };
}
