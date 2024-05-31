import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_cuoiky/resources/color_resources.dart';

class ButtonComponents extends StatelessWidget {
  final String? text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isBorder;
  final Color? borderColor;

  const ButtonComponents(
      {super.key,
      this.text,
      this.onPressed,
      this.width,
      this.height,
      this.color,
      this.textColor,
      this.borderRadius,
      this.fontSize,
      this.fontWeight,
      this.isBorder,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: width ?? .8.sw,// 
      height: height ?? 45.h,
      decoration: BoxDecoration(
          color: color ?? AppColor.WHITE,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: isBorder ?? false
              ? Border.all(color: borderColor ?? AppColor.BLUE, width: 2)
              : const Border.fromBorderSide(BorderSide.none)),
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Center(
          child: Text(
            text ?? 'LOGIN',
            style: GoogleFonts.lexend(
              color: textColor ?? AppColor.BLUE,
              fontSize: fontSize ?? 18.sp,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
