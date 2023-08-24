import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mentz_task/features/models/locations_model.dart';
import 'package:mentz_task/features/repos/home_repo.dart';
import 'package:mentz_task/interceptors/di.dart';
import 'package:mentz_task/utils/appConfig.dart';

class HomeProvider extends ChangeNotifier {
  // The current search text entered by the user.
  String searchData = "";

  // Flags to track loading status.
  bool loadMore = false;
  bool isLoading = false;

  // Data model to hold fetched locations.
  LocationsModel? locationsModel;

  // List to store locations fetched from the API.
  List<Locations> locationsList = [];

  // Timer for debouncing search requests.
  Timer? debounce;

  // Fetch initial data for the home screen.
  Future<void> getDataProvider() async {
    try {
      isLoading = true;
      notifyListeners();

      // Fetch data from the repository.
      LocationsModel res = await sl<HomeRepository>().getDataRepo();

      // Update the model and list, and notify listeners.
      locationsModel = res;
      locationsList = res.locations!;
      isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      // Handle API errors.
      AppConfig().showException(e);
    } finally {
      notifyListeners();
    }
  }

  // Perform a search and update the results.
  getSearchResult() {
    isLoading = true;

    // Clear the existing list of locations.
    locationsList.clear();
    notifyListeners();

    // Fetch new search results.
    getDataProvider();
  }
}
