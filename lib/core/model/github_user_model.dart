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
      GithubUserModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory GithubUserModel.fromJson(Map<String, dynamic> json) =>
      GithubUserModel(
        avatarUrl: json["avatar_url"] as String?,
        url: json["url"] as String?,
        name: json["name"] as String?,
        company: json["company"] as String?,
        blog: json["blog"] as String?,
        location: json["location"] as String?,
        email: json["email"] as String?,
        bio: json["bio"] as String?,
        publicRepos: json["public_repos"] as int?,
        publicGists: json["public_gists"] as int?,
        followers: json["followers"] as int?,
        following: json["following"] as int?,
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
