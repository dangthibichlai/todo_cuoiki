class TaskModel {
  String? title;
  bool? status;
  bool? isDelete;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? userId;
  int? v;

  TaskModel({
    this.title,
    this.status,
    this.isDelete,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.v,
  });

  TaskModel copyWith({
    String? title,
    bool? status,
    bool? isDelete,
    String? id,
    String? userId,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return TaskModel(
      title: title ?? this.title,
      status: status ?? this.status,
      isDelete: isDelete ?? this.isDelete,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'status': status,
      'isDelete': isDelete,
      'userId': userId,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] as String?,
      status: json['status'] as bool?,
      isDelete: json['isDelete'] as bool?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userId: json['userId'] as String?,
      v: json['__v'] as int?,
    );
  }

  @override
  String toString() =>
      "TaskModel(title: $title,status: $status,isDelete: $isDelete,id: $id,createdAt: $createdAt,updatedAt: $updatedAt,v: $v)";

  @override
  int get hashCode => Object.hash(title, status, isDelete, id, createdAt, updatedAt, v);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          status == other.status &&
          isDelete == other.isDelete &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          v == other.v;
}

List<TaskModel> todoListA = [
  TaskModel()
    ..id = '1'
    ..title = 'ngu day'
    ..status = false,
  TaskModel()
    ..id = '2'
    ..title = 'tap the duc'
    ..status = false,
  TaskModel()
    ..id = '3'
    ..title = 'an sang'
    ..status = false,
  TaskModel()
    ..id = '4'
    ..title = 'di den truong'
    ..status = false,
  TaskModel()
    ..id = '5'
    ..title = 'hoc Flutter'
    ..status = false,
  TaskModel()
    ..id = '6'
    ..title = 've nha'
    ..status = false,
  TaskModel()
    ..id = '7'
    ..title = 'nghi trua'
    ..status = false,
  TaskModel()
    ..id = '8'
    ..title = 'hoc tieng anh'
    ..status = false,
  TaskModel()
    ..id = '9'
    ..title = 'di choi'
    ..status = false,
];
