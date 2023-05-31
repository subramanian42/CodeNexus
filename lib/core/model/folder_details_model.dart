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
        tree: _convertToTree(json["tree"] as List<dynamic>),
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

List<Tree>? _convertToTree(List<dynamic>? tree) {
  if (tree == null) return [];

  final List<Map<String, dynamic>> result =
      tree.map((dynamic e) => e as Map<String, dynamic>).toList();

  final List<Tree>? convertedTree =
      List<Tree>.from((result).map((e) => Tree.fromJson(e)));
  return convertedTree;
}
