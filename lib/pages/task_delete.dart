// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_cuoiky/components/header_screen.dart';
import 'package:todo_cuoiky/components/search_box.dart';
import 'package:todo_cuoiky/components/todo_item.dart';
import 'package:todo_cuoiky/models/task_model.dart';
import 'package:todo_cuoiky/pages/task_complete.dart';
import 'package:todo_cuoiky/pages/task_home_page.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';
import 'package:todo_cuoiky/service/task_api.dart';

class TaskDeletePage extends StatefulWidget {
  const TaskDeletePage({super.key, this.title});

  final String? title;

  @override
  State<TaskDeletePage> createState() => _TaskDeletePageState();
}

class _TaskDeletePageState extends State<TaskDeletePage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  TextEditingController addController = TextEditingController();

  FocusNode addFocus = FocusNode();

  List<TaskModel> todos = [];
  List<TaskModel> searchList = [];
  bool showAddBox = false;
  String userId = '';
  ValueNotifier isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    getAllTask();
  }

  void _search(String value) {
    value = value.toLowerCase();
    searchList = todos.where((e) => (e.title ?? '').toLowerCase().contains(value)).toList();
    setState(() {});
  }

  ///
  /// Get Task
  ///
  Future<void> getAllTask() async {
    isLoading.value = true;
    userId = SharedPrefs.userId ?? '';
    await TaskService().getAllTasks(userId: userId, filter: "&isDelete=false").then((value) {
      if (value != null) {
        todos = value;
        searchList = [...todos];
        setState(() {});
      }
      log(todos.toString());
    });
    isLoading.value = false;
  }

  // update task
  Future<void> updateTask(TaskModel task) async {
    await TaskService().updateTask(task).then((value) {
      if (value != null) {
        getAllTask();
        Get.find<TaskHomePageState>().initState();
        Get.find<TaskCompletePageState>().initState();
        _search('');
        setState(() {});
      }
    });
  }

// delete
  Future<void> deleteTask(String idTask) async {
    await TaskService().deleteTask(idTask).then((value) {
      getAllTask();
      _search('');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar:HeaderScreenWidget(
          resetData: () =>  getAllTask(),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SearchBox(
                        controller: searchController,
                        onChanged: _search,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _divider(),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 16.0, bottom: 98.0),
                        itemBuilder: (context, index) {
                          final todo = searchList.reversed.toList()[index];
                          return TodoItem(
                            todo,
                            onTap: () {
                              todo.status = !todo.status!;

                              updateTask(todo);
                              setState(() {});
                            },
                            onEditing: () => _editing(context, todo),
                            onDelete: () => _delete(context, todo),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 20.0),
                        itemCount: searchList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editing(BuildContext context, TaskModel todo) {
    editingController.text = todo.title ?? '';
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundColor: AppColor.BLUE.withOpacity(0.8),
              radius: 14.0,
              child: const Icon(Icons.edit, size: 16.0, color: AppColor.white),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(controller: editingController),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(color: AppColor.blue, fontSize: 16.8),
              ),
              onPressed: () {
                todo.title = editingController.text.trim();
                updateTask(todo);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColor.blue, fontSize: 16.8),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _delete(BuildContext context, TaskModel todo) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('😐'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Delete this todo?',
                  style: TextStyle(color: AppColor.brown, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColor.blue, fontSize: 16.8),
              ),
              onPressed: () {
                deleteTask(todo.id!);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: AppColor.blue, fontSize: 16.8),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1.2,
      thickness: 1.2,
      indent: 20.0,
      endIndent: 20.0,
      color: AppColor.grey,
    );
  }
}
