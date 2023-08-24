import 'package:flutter/material.dart';
import 'package:mentz_task/features/controllers/home_provider.dart';
import 'package:mentz_task/features/ui/home_screen.dart';
import 'package:mentz_task/features/ui/splash_screen.dart';
import 'package:mentz_task/interceptors/di.dart';
import 'package:mentz_task/routing/routes.dart';
import 'package:mentz_task/utils/appConfig.dart';
import 'package:provider/provider.dart';

class RouterX {
  // Generate routes based on the given RouteSettings.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // Splash Screen Route
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<AppConfig>(),
            child: SplashScreen(),
          ),
        );

      // Home Screen Route
      case Routes.home:
        return MaterialPageRoute(builder: (_) {
          return ChangeNotifierProvider.value(
            value: sl<HomeProvider>(),
            child: const HomeScreen(),
          );
        });

      // Default Route for undefined routes
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
