import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamzi/Modules/screens/order_screen.dart';
import '../screens/Customization_Thali.dart';
import '../screens/home_Screen.dart';

class CommonDashController extends GetxController {
  var selectedIndex = 0.obs;

  int changeIndex() {
    if (selectedIndex.value <= 4) {
      return selectedIndex.value;
    } else {
      return 0;
    }
  }

  final List pages = [
    HomeScreen(), // index 0
    CustomizationScreen(),// Add/Post screen
    OrderScreen(),
    Container(color: Colors.purple), // Reels
    Container(color: Colors.green), // Profile
  ];
}
