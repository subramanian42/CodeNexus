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
      OrganizationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      OrganizationModel(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        url: json["url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        hooksUrl: json["hooks_url"],
        issuesUrl: json["issues_url"],
        membersUrl: json["members_url"],
        publicMembersUrl: json["public_members_url"],
        avatarUrl: json["avatar_url"],
        description: json["description"],
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
