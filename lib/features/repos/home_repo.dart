import 'package:dio/dio.dart';
import 'package:mentz_task/api/remote/auth_api.dart';
import 'package:mentz_task/features/controllers/home_provider.dart';
import 'package:mentz_task/features/models/locations_model.dart';
import 'package:mentz_task/interceptors/di.dart';

class HomeRepository {
  // Access the HomeProvider instance using Dependency Injection (DI).
  var homeProvider = sl<HomeProvider>();

  // Fetch data from the API using search text.
  Future<LocationsModel> getDataRepo() async {
    try {
      // Construct the API URL based on the search text.
      final response = await sl<HttpAuth>().getData(
        url:
            "&name_sf=${homeProvider.searchData.isEmpty ? "ph" : homeProvider.searchData.trim()}",
      );

      // Print the response data for debugging.
      print("${response.data}");

      // Parse the response data into a LocationsModel object.
      LocationsModel locationsModel = LocationsModel.fromJson(response.data);
      return locationsModel;
    } on DioException catch (e) {
      // Rethrow the DioException for error handling at a higher level.
      rethrow;
    }
  }
}
