import 'dart:convert';

class OrganizationModel {
  final String? login;
  final int? id;
  final String? nodeId;
  final String? url;
  final String? reposUrl;
  final String? eventsUrl;
  final String? hooksUrl;
  final String? issuesUrl;
  final String? membersUrl;
  final String? publicMembersUrl;
  final String? avatarUrl;
  final String? description;

  OrganizationModel({
    this.login,
    this.id,
    this.nodeId,
    this.url,
    this.reposUrl,
    this.eventsUrl,
    this.hooksUrl,
    this.issuesUrl,
    this.membersUrl,
    this.publicMembersUrl,
    this.avatarUrl,
    this.description,
  });

  factory OrganizationModel.fromRawJson(String str) =>
      OrganizationModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      OrganizationModel(
        login: json["login"] as String?,
        id: json["id"] as int?,
        nodeId: json["node_id"] as String?,
        url: json["url"] as String?,
        reposUrl: json["repos_url"] as String?,
        eventsUrl: json["events_url"] as String?,
        hooksUrl: json["hooks_url"] as String?,
        issuesUrl: json["issues_url"] as String?,
        membersUrl: json["members_url"] as String?,
        publicMembersUrl: json["public_members_url"] as String?,
        avatarUrl: json["avatar_url"] as String?,
        description: json["description"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "url": url,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "hooks_url": hooksUrl,
        "issues_url": issuesUrl,
        "members_url": membersUrl,
        "public_members_url": publicMembersUrl,
        "avatar_url": avatarUrl,
        "description": description,
      };
}
