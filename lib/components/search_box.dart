import 'package:flutter/material.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        // border: Border.all(color: AppColor.BLUE),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: AppColor.red),
          prefixIconConstraints: BoxConstraints(minWidth: 28.0),
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColor.grey),
        ),
      ),
    );
  }
}
