
import 'package:flutter/cupertino.dart';

class SelectedListNavigationProvider extends ChangeNotifier{

  bool _scrollingUp = false;
  double _pixels = 0;
  ScrollPhysics _physics = const BouncingScrollPhysics();


  get scrollingUp => _scrollingUp;
  get pixels => _pixels;
  get physics => _physics;

  set updateScrollingUp(bool value) {
    _scrollingUp = value;
    notifyListeners();
  }

  set updatePixels(double value) {
    _pixels = value;
    notifyListeners();
  }

  set updatePhysics(ScrollPhysics value) {
    _physics = value;
    notifyListeners();
  }
}