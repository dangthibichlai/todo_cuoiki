import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_cuoiky/models/task_model.dart';
import 'package:todo_cuoiky/resources/alert_app.dart';
import 'package:todo_cuoiky/resources/end-point.dart';
import 'package:http/http.dart' as http;
import 'package:todo_cuoiky/service/shared_prefs.dart';

class TaskService {
  // get all tasks true là đã hoàn thành và false là chưa hoàn thành
  Future<List<TaskModel>> getAllTasks({required String userId, String? filter}) async {
    String url = '${EndPoint.tasks}?userId=$userId';
    if (filter != null) {
      // ignore: unused_local_variable
      url = '${EndPoint.tasks}?userId=$userId$filter';
    }
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // thêm
  Future<TaskModel> addTask(
    TaskModel task,
  ) async {
    final response = await http.post(
      Uri.parse(EndPoint.tasks),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      AlertApp.showAlert(title: json.decode(response.body)['errorType']);
      throw Exception('Failed to add task');
    }
  }

  // cập nhật
  Future<TaskModel> updateTask(TaskModel task) async {
    final response = await http.put(
      Uri.parse('${EndPoint.tasks}/${task.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      EasyLoading.dismiss();

      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update task');
    }
  }

  // xóa
  Future<void> deleteTask(String id) async {
    final response = await http.delete(
      Uri.parse('${EndPoint.tasks}/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
