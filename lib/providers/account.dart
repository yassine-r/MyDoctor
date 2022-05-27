import 'package:flutter/cupertino.dart';

class Account with ChangeNotifier {
  String _id = "";
  bool _isFacility = true;
  bool canCreateOrder = false;

  String getid() {
    return _id;
  }

  void setId(String id) {
    _id = id;
    notifyListeners();
  }

  bool getIsFacility() {
    return _isFacility;
  }

  void isChanged() {
    notifyListeners();
  }

  void setIsFacility(bool test) {
    _isFacility = test;
    notifyListeners();
  }

  bool getcanCreateOrder() {
    if (canCreateOrder == true) {
      print("authorized");
    }
    return canCreateOrder;
  }

  void setcanCreateOrder(bool test) {
    canCreateOrder = test;
  }
}
