import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertApp {
  AlertApp.showAlert({String? title, Color? color, double? fontSize, Color? colorText}) {
    Fluttertoast.showToast(
        msg: title ?? "Please enter your email",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.red,
        textColor: colorText ?? Colors.white,
        fontSize: fontSize ?? 16.0);
  }
}
