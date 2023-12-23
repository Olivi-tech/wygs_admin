import 'package:flutter/material.dart';
class ImagePickerProvider extends ChangeNotifier {
  String imagePath = '';
  String get path => imagePath;
  set setPath(String path) {
    imagePath = path;
    notifyListeners();
  }

  
  void deleteImage() {
    imagePath = '';
    notifyListeners();
}
}