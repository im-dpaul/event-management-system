import 'package:flutter/material.dart';
import 'package:event_management_system/main.dart';

class DashboardProvider with ChangeNotifier {
  int selectedIndex = 1;
  bool isSettingsScreen = false;

  String userName = fName;

  void setName(String name) {
    userName = name;
    notifyListeners();
  }

  void changeTab(int index, PageController pageController) {
    isSettingsScreen = (index == 2) ? true : false;
    selectedIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
