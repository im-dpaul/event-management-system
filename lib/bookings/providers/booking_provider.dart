import 'package:flutter/foundation.dart';

class BookingProvider with ChangeNotifier {
  bool isChecked = false;
  int tickets = 1;

  void setCheck() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void noOfTickets(int val) {
    tickets = val;
    notifyListeners();
  }
}
