import 'package:flutter/material.dart';

class ProgressCheckProvider extends ChangeNotifier {
  List<int> selectedIndices = [];
  bool isAllSeleted = false;
  void toogle(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  bool isSelected(int index) {
    return selectedIndices.contains(index);
  }

  selectAll(List items) {
    isAllSeleted = !isAllSeleted;
    if (items.length == selectedIndices.length) {
      selectedIndices.clear();
      notifyListeners();
    } else {
      selectedIndices.clear();
      for (var i = 0; i < items.length; i++) {
        toogle(i);
      }
    }
  }
}
