import 'package:flutter/material.dart';

class GuestCheckProvider extends ChangeNotifier {
  List<int> selectedIndices = [];
  bool isAllSeleted = false;

  void toggleChecked(int index) {
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
      for (int i = 0; i < items.length; i++) {
        toggleChecked(i);
      }
    }
  }
}
