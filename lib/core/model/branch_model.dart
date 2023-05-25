import 'dart:convert';

class Branch {
  final String? name;

  final bool? protected;

  Branch({
    this.name,
    this.protected,
  });

  factory Branch.fromRawJson(String str) =>
      Branch.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        name: json["name"] as String?,
        protected: json["protected"] as bool?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "protected": protected,
      };
}
