import 'dart:convert';

class AuthUserModel {
  final String? id;
  final String? token;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? avatarUrl;
  final String? role;
  final bool? isActive;
  final DateTime? joinedAt;
  final DateTime? lastLogin;

  AuthUserModel({
    this.id,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.avatarUrl,
    this.role,
    this.isActive,
    this.joinedAt,
    this.lastLogin,
  });

  AuthUserModel copyWith({
    String? id,
    String? token,
    String? firstName,
    String? lastName,
    String? email,
    String? avatarUrl,
    String? role,
    bool? isActive,
    DateTime? joinedAt,
    DateTime? lastLogin,
  }) => AuthUserModel(
    id: id ?? this.id,
    token: token ?? this.token,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    joinedAt: joinedAt ?? this.joinedAt,
    lastLogin: lastLogin ?? this.lastLogin,
  );

  factory AuthUserModel.fromRawJson(String str) =>
      AuthUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
    id: json["id"],
    token: json["token"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    avatarUrl: json["avatar_url"],
    role: json["role"],
    isActive: json["is_active"],
    joinedAt: json["joined_at"] == null
        ? null
        : DateTime.parse(json["joined_at"]),
    lastLogin: json["last_login"] == null
        ? null
        : DateTime.parse(json["last_login"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "avatar_url": avatarUrl,
    "role": role,
    "is_active": isActive,
    "joined_at": joinedAt?.toIso8601String(),
    "last_login": lastLogin?.toIso8601String(),
  };
}
