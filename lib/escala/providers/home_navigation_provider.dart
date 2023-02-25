
import 'package:flutter/cupertino.dart';

class HomeNavigationProvider extends ChangeNotifier{
  int _homePageViewIndex = 0;
  int get homePageIndex => _homePageViewIndex;

  bool get hideBottomPanel => _homePageViewIndex == 0;


  void updateHomePageIndex(int newValue) {
    _homePageViewIndex = newValue;
    notifyListeners();
  }
}