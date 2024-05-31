class AuthModel {
  String? accessToken;
  User? user;

  AuthModel({
    this.accessToken,
    this.user,
  });

  AuthModel copyWith({
    String? accessToken,
    User? user,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': user,
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() => "Response(accessToken: $accessToken,user: $user)";

  @override
  int get hashCode => Object.hash(accessToken, user);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModel &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          user == other.user;
}

class User {
  String? id;
  String? username;
  String? password;
  String? role;
  String? avatar;
  String? fullName;
  String? language;
  bool? isDelete;
  String? email;
  List<String>? fcmToken;
  String? createdAt;
  String? updatedAt;
  int? v;

  User({
    this.id,
    this.username,
    this.password,
    this.role,
    this.avatar,
    this.fullName,
    this.language,
    this.isDelete,
    this.email,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  User copyWith({
    String? id,
    String? username,
    String? password,
    String? role,
    String? avatar,
    String? fullName,
    String? language,
    bool? isDelete,
    String? email,
    List<String>? fcmToken,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      language: language ?? this.language,
      isDelete: isDelete ?? this.isDelete,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'role': role,
      'avatar': avatar,
      'full_name': fullName,
      'language': language,
      'isDelete': isDelete,
      'email': email,
      'fcm_token': fcmToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      avatar: json['avatar'] as String?,
      fullName: json['full_name'] as String?,
      language: json['language'] as String?,
      isDelete: json['isDelete'] as bool?,
      email: json['email'] as String?,
      fcmToken: (json['fcm_token'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
    );
  }

  @override
  String toString() =>
      "User(id: $id,username: $username,password: $password,role: $role,avatar: $avatar,fullName: $fullName,language: $language,isDelete: $isDelete,email: $email,fcmToken: $fcmToken,createdAt: $createdAt,updatedAt: $updatedAt,v: $v)";

  @override
  int get hashCode => Object.hash(id, username, password, role, avatar,
      fullName, language, isDelete, email, fcmToken, createdAt, updatedAt, v);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          password == other.password &&
          role == other.role &&
          avatar == other.avatar &&
          fullName == other.fullName &&
          language == other.language &&
          isDelete == other.isDelete &&
          email == other.email &&
          fcmToken == other.fcmToken &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          v == other.v;
}
