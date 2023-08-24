import 'package:flutter/material.dart';
import 'package:mentz_task/features/controllers/home_provider.dart';
import 'package:mentz_task/resources/color_manager.dart';
import 'package:mentz_task/resources/strings_manager.dart';
import 'package:mentz_task/resources/values_manager.dart';

class NoResultWidget extends StatelessWidget {
  final HomeProvider homeProvider;
  const NoResultWidget({Key? key, required this.homeProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: AppSize.s20,
          ),
          children: [
            const TextSpan(
              text: AppString.noResult,
              style: TextStyle(
                color: ColorManager.borderGrey,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: '" ${homeProvider.searchData} "',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
