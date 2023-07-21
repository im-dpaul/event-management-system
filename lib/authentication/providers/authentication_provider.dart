import 'package:event_management_system/authentication/repository/auth_repository.dart';
import 'package:event_management_system/providers/loading_provider.dart';
import 'package:flutter/foundation.dart';

class AuthenticationProvider with ChangeNotifier {
  final authRepo = AuthRepository();
  final loadingProvider = LoadingProvider();
  String result = 'failed';

  Future<String> emailLogin(String email, String password) async {
    loadingProvider.isLoading = true;
    //result = await authRepo.loginWithEmail(email, password);
    loadingProvider.isLoading = false;
    notifyListeners();
    return result;
  }
}
