import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_task/interceptors/di.dart';
import 'package:mentz_task/interceptors/dio_exception.dart';
import 'package:mentz_task/resources/color_manager.dart';
import 'package:mentz_task/routing/navigation.dart';
import 'package:mentz_task/routing/routes.dart';

class AppConfig extends ChangeNotifier {
  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    sl<NavigationService>().navigateToAndRemove(Routes.home, args: 0);
  }

  TextTheme getTextContext(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static showSnakBar(String content, {bool success = false}) {
    return sl<NavigationService>()
        .snackBarKey
        .currentState
        ?.showSnackBar(SnackBar(
          content: Text(
            content,
          ),
          backgroundColor: success ? ColorManager.primary : ColorManager.black,
          behavior: SnackBarBehavior.floating,
        ));
  }

  static showCustomSnackBar(String content) {
    return sl<NavigationService>()
        .snackBarKey
        .currentState
        ?.showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorManager.white, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
          content: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_sharp,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  content,
                  style: TextStyle(color: ColorManager.black, fontSize: 16.sp),
                ),
              ],
            ),
          ),
          backgroundColor: ColorManager.black,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 264.h, left: 28, right: 28),
        ));
  }

  showException(DioException e) {
    final errorMessage = DioExceptions.fromDioError(e).toString();
    AppConfig.showSnakBar(
        "${e.response != null && e.response!.data["message"] != "" ? e.response!.data["message"] : errorMessage}",
        success: false);
  }

  showCustomException(DioException e) {
    final errorMessage = DioExceptions.fromDioError(e).toString();
    AppConfig.showCustomSnackBar(
      "${e.response != null && e.response!.data["message"] != "" ? e.response!.data["message"] : errorMessage}",
    );
  }
}
