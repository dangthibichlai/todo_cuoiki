class UserModel {
  String? id;
  String? username;
  String? password;
  String? role;
  String? avatar;
  String? fullName;
  bool? isDelete;
  String? email;
  List<String>? fcmToken;
  UserModel({
    this.id,
    this.username,
    this.password,
    this.role,
    this.avatar,
    this.fullName,
    this.isDelete,
    this.email,
    this.fcmToken,
  });
  UserModel copyWith({
    String? id,
    String? username,
    String? password,
    String? role,
    String? avatar,
    String? fullName,
    bool? isDelete,
    String? email,
    List<String>? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      isDelete: isDelete ?? this.isDelete,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'role': role,
      'avatar': avatar,
      'fcm_token': fullName,
      'isDelete': isDelete,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      avatar: json['avatar'] as String?,
      fullName: json['fcm_token'] as String?,
      isDelete: json['isDelete'] as bool?,
      email: json['email'] as String?,
      fcmToken: json['fcm_token'] != null ? List<String>.from(json['fcm_token']) : null,
    );
  }
}
