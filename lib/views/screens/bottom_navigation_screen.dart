import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/views/screens/home_screen.dart';
import 'package:google_maps/views/screens/poetry_screen.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});
  List<Widget> screens = [HomeScreen(), PoetryScreen(name: '')];
  RxInt selectedIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return screens[selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.black12,
            // fixedColor: Colors.black12,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            // selectedLabelStyle: TextStyle(color: Colors.black),
            currentIndex: selectedIndex.value,
            onTap: (value) {
              selectedIndex.value = value;
            },
            items: [BottomNavigationBarItem(label: 'Online Poetry', icon: Icon(Icons.cloud_done)), BottomNavigationBarItem(label: 'Offline Poetry', icon: Icon(Icons.cloud_off))]);
      }),
    );
  }
}
