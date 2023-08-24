import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentz_task/interceptors/di.dart';
import 'package:mentz_task/routing/navigation.dart';
import 'package:mentz_task/routing/router.dart';
import 'package:mentz_task/routing/routes.dart';
import 'package:mentz_task/utils/appConfig.dart';

import 'resources/theme_manager.dart';

void main() async {
  // Ensure that Flutter is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure that ScreenUtil's screen size is initialized.
  await ScreenUtil.ensureScreenSize();

  // Initialize dependency injection (DI).
  await init();

  // Load app configuration (splash data).
  sl<AppConfig>().loadData();

  // Set preferred device orientations and system UI overlay style.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // Run the app.
  runApp(
    const MyApp(),
  );
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(390, 844), // Set the design size for screen adaptation
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          scaffoldMessengerKey: sl<NavigationService>().snackBarKey,
          debugShowCheckedModeBanner: false,
          title: 'Mentz',
          theme: getApplicationTheme(),
          navigatorKey: sl<NavigationService>().navigatorKey,
          initialRoute: Routes.splash,
          onGenerateRoute: RouterX.generateRoute,
        );
      },
    );
  }
}
