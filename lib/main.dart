import 'package:car_project/core/utils/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/cache/prefs.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/on_generate_route.dart';
import 'core/services/service_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init shared preferences
  await Prefs.init();
  // setup service locator
  setupGetit();
  runApp(const CarApp());
}

class CarApp extends StatelessWidget {
  const CarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor,
        appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: AppColors.whiteColor),
      ),
      debugShowCheckedModeBanner: false,
      // Puth routes to navigation
      onGenerateRoute: onGenerateRoutes,
      // set the initioal route
      initialRoute: AppRoutes.onBoarding,
    );
  }
}


// MVVM => Model View ViewModel 