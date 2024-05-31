import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';
import 'package:todo_cuoiky/resources/text_controller.dart';

class TextFiledComponent extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isPhone;
  final bool? isNumber;
  final EdgeInsets? contentPadding;

  const TextFiledComponent(
      {super.key,
      this.hintText,
      this.controller,
      this.textInputType,
      this.obscureText,
      this.isPassword,
      this.isEmail,
      this.isPhone,
      this.isNumber,
      this.contentPadding});

  @override
  State<TextFiledComponent> createState() => _TextFiledComponentState();
}

class _TextFiledComponentState extends State<TextFiledComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      width: .8.sw,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Enter your email',
          contentPadding: widget.contentPadding ?? EdgeInsets.only(left: 10, right: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.BLUE, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gapPadding: 10,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.BLUE, width: 2),
          ),
        ),
      ),
    );
  }
}
