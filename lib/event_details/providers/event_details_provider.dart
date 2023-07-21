import 'package:flutter/material.dart';

class EventDetailsProvider with ChangeNotifier {
  bool isFav = false;
  void setIsFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
