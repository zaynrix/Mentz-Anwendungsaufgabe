import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_task/features/controllers/home_provider.dart';
import 'package:mentz_task/features/widgets/details_widget.dart';
import 'package:mentz_task/features/widgets/no_result_widget.dart';
import 'package:mentz_task/features/widgets/schimmer.dart';
import 'package:mentz_task/features/widgets/text_field.dart';
import 'package:mentz_task/interceptors/di.dart';
import 'package:mentz_task/resources/color_manager.dart';
import 'package:mentz_task/resources/strings_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final homeProvider = sl<HomeProvider>();
    homeProvider.getDataProvider();
  }

  Widget buildSearchTextField(HomeProvider value) {
    return MainTextField(
      validator: (p) => "",
      text: "Search",
      textInputType: TextInputType.text,
      onChanged: (val) {
        if (value.debounce?.isActive ?? false) {
          value.debounce?.cancel();
        }

        value.debounce = Timer(const Duration(milliseconds: 150), () {
          value.searchData = val!;
          value.getSearchResult();
        });
      },
    );
  }

  Widget buildLocationsList(HomeProvider value) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: value.locationsList.length,
      itemBuilder: (context, index) {
        var user = value.locationsList[index];
        final highlightedName =
            highlightSearchQuery(user.name!, value.searchData);
        final highlightedType =
            highlightSearchQuery(user.type!, value.searchData);

        return Card(
          color: ColorManager.blackCard,
          child: ExpansionTile(
            title: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: AppString.name,
                      style: TextStyle(color: ColorManager.borderGrey)),
                  highlightedName,
                ],
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: AppString.type,
                      style: TextStyle(color: ColorManager.borderGrey)),
                  highlightedType,
                ],
              ),
            ),
            children: [
              DetailsWidget(location: user), // Additional details here.
            ],
          ),
        );
      },
    );
  }

  Widget RowDetails(String label, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: ColorManager.borderGrey),
            overflow: TextOverflow.visible,
          ),
        ),
        Flexible(
          child: Text(
            "$value",
            textAlign: TextAlign.end,
            style: const TextStyle(color: ColorManager.white),
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  TextSpan highlightSearchQuery(String text, String query) {
    final highlightedText = RegExp(query, caseSensitive: false);
    final matches = highlightedText.allMatches(text);

    final List<InlineSpan> children = [];
    int previousMatchEnd = 0;

    for (final match in matches) {
      children.add(
        TextSpan(
          text: text.substring(previousMatchEnd, match.start),
        ),
      );
      children.add(
        TextSpan(
          text: match.group(0),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorManager.primaryBlue,
          ),
        ),
      );
      previousMatchEnd = match.end;
    }

    children.add(
      TextSpan(
        text: text.substring(previousMatchEnd),
      ),
    );

    return TextSpan(children: children);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: GestureDetector(
        onTap: () {
          // Hide the keyboard when tapping outside of a text field.
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) => Column(
              children: [
                SizedBox(height: 50.h),
                buildSearchTextField(homeProvider),
                SizedBox(height: 20.h),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await homeProvider.getSearchResult();
                    },
                    child: homeProvider.locationsList.isEmpty
                        ? homeProvider.isLoading
                            ? const ListShimmer()
                            : NoResultWidget(
                                homeProvider: homeProvider,
                              )
                        : buildLocationsList(homeProvider),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
