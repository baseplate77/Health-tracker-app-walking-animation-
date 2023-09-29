import 'package:flutter/cupertino.dart';

class PageNotifier extends ChangeNotifier {
  double page = 0.0;

  // PageController pageController;

  listener(double value) {
    page = value;
    // print("page : $page");
    notifyListeners();
  }
}
