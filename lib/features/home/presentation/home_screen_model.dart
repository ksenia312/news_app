import 'package:flutter/cupertino.dart';

class HomeSearchModel extends ChangeNotifier {
  bool showSearchPanel = false;

  void toggleSearch() {
    showSearchPanel = !showSearchPanel;
    notifyListeners();
  }
}
