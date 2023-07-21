import 'package:flutter/foundation.dart';

class PasswordFieldProvider with ChangeNotifier {
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  void setPasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    notifyListeners();
  }

  void setConfirmPasswordVisibility() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    notifyListeners();
  }
}
