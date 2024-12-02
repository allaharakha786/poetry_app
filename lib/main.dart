import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps/controllers/getxControllers/poetry_controller.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';
import 'package:google_maps/views/screens/bottom_navigation_screen.dart';
import 'package:google_maps/views/screens/home_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  Get.lazyPut(() => PoetryController());
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.init();

  Firebase.initializeApp();
  MobileAds.instance.initialize();
  // MySharedPreferences.setStringList('myList', []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: Size(mediaQuerySize.width, mediaQuerySize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: BottomNavigationScreen(),
      ),
    );
  }
}
