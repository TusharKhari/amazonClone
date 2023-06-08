import 'package:flutter/cupertino.dart';

class FunctionProvider extends ChangeNotifier {
   String ? oldVal;
  void getOldVal(oldVal) {
    this.oldVal = oldVal;
    notifyListeners();
  }

   String ? newVal;
  void getNewVal(newVal) {
    this.newVal = newVal;
    print(oldVal! + " " + newVal);
    notifyListeners();
  }

  void setVal() {
    oldVal = newVal;
    notifyListeners();
  }

  void f(oldVal, newVal) {
    oldVal = newVal;
    notifyListeners();
  }

  void setImage(var oldV, var newV) {
    oldVal = newVal;
    notifyListeners();
  }
}
