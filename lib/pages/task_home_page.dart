// ignore_for_file: await_only_futures, unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:todo_cuoiky/components/header_screen.dart';
import 'package:todo_cuoiky/components/no_data.dart';
import 'package:todo_cuoiky/components/search_box.dart';
import 'package:todo_cuoiky/components/shimmer.dart';
import 'package:todo_cuoiky/components/todo_item.dart';
import 'package:todo_cuoiky/models/task_model.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/service/shared_prefs.dart';
import 'package:todo_cuoiky/service/task_api.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key, this.title});

  final String? title;

  @override
  State<TaskHomePage> createState() => TaskHomePageState();
}

class TaskHomePageState extends State<TaskHomePage> {
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
    await TaskService().getAllTasks(userId: userId, filter: "&status=false&isDelete=false").then((value) {
      if (value != null) {
        todos = value;
        searchList = [...todos];
        setState(() {});
      }
      log(todos.toString());
    });
    isLoading.value = false;
  }

  ///
  ///Add Task
  ///
  Future<void> addTask(String title) async {
    EasyLoading.show(status: 'Loading...');
    TaskModel task = TaskModel()
      ..title = title
      ..status = false
      ..isDelete = false
      ..userId = userId;

    await TaskService().addTask(task).then((value) {
      if (value != null) {
        todos.add(value);
        _search('');
        addController.clear();
        searchController.clear();
        addFocus.unfocus();
        showAddBox = false;
        setState(() {});
      }
    });
    EasyLoading.dismiss();
  }

  // update task
  Future<void> updateTask(TaskModel task) async {
    await TaskService().updateTask(task).then((value) {
      if (value != null) {
        getAllTask();
        _search('');
        setState(() {});
      }
    });
  }
  // delete task

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: HeaderScreenWidget(
          resetData: () => getAllTask(),
        ),
        body: Stack(
          children: [
            todos.isEmpty && !isLoading.value
                ? const NoTask()
                : Positioned.fill(
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
                                return isLoading.value
                                    ? const ShimmerLoading()
                                    : TodoItem(
                                        todo,
                                        onTap: () {
                                          todo.status = true;

                                          updateTask(todo);
                                          setState(() {});
                                        },
                                        onEditing: () => _editing(context, todo),
                                        onDelete: () {
                                          todo.isDelete = true;
                                          updateTask(todo);
                                          setState(() {});
                                        },
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
            Positioned(
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
              child: Row(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: showAddBox,
                      child: _addBox(),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  _addButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addButton() {
    return GestureDetector(
      onTap: () {
        if (!showAddBox) {
          showAddBox = true;
          setState(() {});
          addFocus.requestFocus();
          return;
        }

        String text = addController.text.trim();
        if (text.isEmpty) {
          showAddBox = false;
          setState(() {});
          addFocus.unfocus();
          return;
        }

        addTask(text);
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColor.BLUE,
          border: Border.all(color: const Color.fromARGB(255, 27, 14, 162), width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: const Icon(Icons.add, size: 32.6, color: AppColor.white),
      ),
    );
  }

  Widget _addBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.BLUE, width: 1.2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (value) {
          addTask(value);
          setState(() {});
        },
        controller: addController,
        focusNode: addFocus,
        decoration: const InputDecoration(border: InputBorder.none),
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
