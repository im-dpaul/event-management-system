import 'package:flutter/foundation.dart';

class ExploreTabProvider with ChangeNotifier {
  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  void changeIndex(index) {
    _activeIndex = index;
    notifyListeners();
  }
}
