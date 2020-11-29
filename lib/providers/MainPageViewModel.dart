import 'package:flutter/cupertino.dart';

class MainPageProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
