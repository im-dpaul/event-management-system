import 'package:event_management_system/utils/shared/shared_widgets/loading.dart';
import 'package:flutter/foundation.dart';

class LoadingProvider with ChangeNotifier {
  bool isLoading = false;
  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
