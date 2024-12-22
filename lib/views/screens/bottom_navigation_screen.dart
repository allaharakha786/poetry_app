import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';
import 'package:google_maps/controllers/utills/app_textStyles.dart';
import 'package:google_maps/views/screens/feed_screen.dart';
import 'package:google_maps/views/screens/home_screen.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});
  List<Widget> screens = [HomeScreen(isOffline: true), HomeScreen(isOffline: false), FeedScreen()];
  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return screens[selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            backgroundColor: AppColors.bottomNavigationColor,
            elevation: 0,
            unselectedItemColor: AppColors.white60Color,
            selectedItemColor: AppColors.whiteColor,
            currentIndex: selectedIndex.value,
            onTap: (value) {
              selectedIndex.value = value;
            },
            unselectedLabelStyle: AppTextstyles.simpleTextStyle().copyWith(fontSize: 12),
            selectedLabelStyle: AppTextstyles.simpleTextStyle().copyWith(fontSize: 14),
            items: [BottomNavigationBarItem(label: 'Offline Poetry', icon: Icon(Icons.cloud_off)), BottomNavigationBarItem(label: 'Online Poetry', icon: Icon(Icons.cloud_done)), BottomNavigationBarItem(label: 'Poetry Feed', icon: Icon(Icons.feed))]);
      }),
    );
  }
}
