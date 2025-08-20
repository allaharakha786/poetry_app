import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps/views/screens/bottom_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Get.offAll(() => BottomNavigationScreen());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mediaQuerySize.height,
        width: mediaQuerySize.width,
        decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/poetry_splash_background.png'))),
        child: Center(
          child: Stack(
            children: [
              Container(
                height: mediaQuerySize.height * 0.44.h,
                width: mediaQuerySize.width * 0.9.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FadeInImage(
                  fadeInDuration: Duration(seconds: 1),
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  image: AssetImage('assets/images/poets.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 95,
                child: Container(
                  height: mediaQuerySize.height * 0.5.h,
                  width: mediaQuerySize.width * 0.9.w,
                  decoration: const BoxDecoration(),
                  child: FadeInImage(
                    fadeInDuration: Duration(seconds: 1),
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    image: AssetImage('assets/images/title.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
