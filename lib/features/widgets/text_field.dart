import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_task/resources/color_manager.dart';
import 'package:mentz_task/resources/font_manager.dart';
import 'package:mentz_task/resources/styles_manager.dart';

class MainTextField extends StatelessWidget {
  const MainTextField(
      {Key? key,
      required this.validator,
      required this.text,
      required this.textInputType,
      this.obscure = false,
      this.onChanged,
      this.controller})
      : super(key: key);

  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: const TextStyle(
          fontSize: 18,
          color: ColorManager.white,
          fontWeight: FontWeight.normal),
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          hintStyle: getRegularStyle(
              color: ColorManager.white.withOpacity(0.7),
              fontSize: FontSize.s18.sp),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(
              color: ColorManager.buttonBlue,
            ),
          ),
          fillColor: Colors.transparent,
          border: InputBorder.none,
          hintText: text,
          contentPadding:
              EdgeInsetsDirectional.only(start: 34.h, top: 22.h, bottom: 20.h)),
      keyboardType: textInputType,
      obscureText: obscure,
      onFieldSubmitted: (value) {
        debugPrint(value);
      },
    );
  }
}
