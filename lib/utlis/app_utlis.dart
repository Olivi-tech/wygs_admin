import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AppUtlis {
  static Future<Uint8List?> getImageFromGallery(
      {required BuildContext context}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<ImagePickerProvider>().setPath = pickedFile.path;
      });
      Uint8List image = await pickedFile.readAsBytes();
      return image;
    } else {
      return null;
    }
  }
  

  static Future<Uint8List> storeImageToFirebase(BuildContext context) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Uint8List? image = await AppUtlis.getImageFromGallery(context: context);
    final profileImage =
        firebaseStorage.ref('profile_image').child('admin_profile');
    try {
      await profileImage
          .putData(image!, SettableMetadata(contentType: "image/png"))
          .then((value) async {
        String profileImageUrl = await profileImage.getDownloadURL();
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<ImagePickerProvider>().setPath = profileImageUrl;
        });
      });

      return Uint8List.fromList([]);
    } on FirebaseException catch (error) {
      log('Image Uploading Error:$error ');

      return Uint8List.fromList([]);
    }
  }
  
}
int extractDayValue(String input) {
    RegExp regExp = RegExp(r'\d+');
    Match? match = regExp.firstMatch(input);
    if (match != null) {
      return int.parse(match.group(0)!);
    } else {
      return 0;
    }
  }

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.BOTTOM_RIGHT,
      webBgColor: "4683C4",
      textColor: AppColor.white,
      fontSize: 16.0);
}
