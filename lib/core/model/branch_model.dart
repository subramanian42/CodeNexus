import 'dart:convert';

class Branch {
  final String? name;

  final bool? protected;

  Branch({
    this.name,
    this.protected,
  });

  factory Branch.fromRawJson(String str) => Branch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        name: json["name"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "protected": protected,
      };
}
