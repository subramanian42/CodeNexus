import 'dart:convert';

class GithubUserModel {
  final String? avatarUrl;
  final String? url;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final int? publicRepos;
  final int? publicGists;
  final int? followers;
  final int? following;

  const GithubUserModel({
    this.avatarUrl,
    this.url,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
  });
  static GithubUserModel get empty => const GithubUserModel(name: "");
  factory GithubUserModel.fromRawJson(String str) =>
      GithubUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GithubUserModel.fromJson(Map<String, dynamic> json) =>
      GithubUserModel(
        avatarUrl: json["avatar_url"],
        url: json["url"],
        name: json["name"],
        company: json["company"],
        blog: json["blog"],
        location: json["location"],
        email: json["email"],
        bio: json["bio"],
        publicRepos: json["public_repos"],
        publicGists: json["public_gists"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "url": url,
        "name": name,
        "company": company,
        "blog": blog,
        "location": location,
        "email": email,
        "bio": bio,
        "public_repos": publicRepos,
        "public_gists": publicGists,
        "followers": followers,
        "following": following,
      };
}
