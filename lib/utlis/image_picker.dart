import 'dart:developer';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guitar_songs/providers/image_picker_provider.dart';
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

  // static Future<Uint8List> storeImageToFirebase(BuildContext context) async {
  //   final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  //   Uint8List? image = await AppUtlis.getImageFromGallery(context: context);
  //   final profileImage = firebaseStorage.ref('profileImage').child('image');
  //   try {
  //     await profileImage
  //         .putData(image!, SettableMetadata(contentType: "image/png"))
  //         .then((value) async {
  //       String profileImageUrl = await profileImage.getDownloadURL();
  //       SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //         context.read<ImagePickerProvider>().setPath = profileImageUrl;
  //       });
  //     });
  //   } on FirebaseException catch (error) {
  //     log('Image Uploading Error:$error ');

  //   }
  // }
  static Future<Uint8List> storeImageToFirebase(BuildContext context) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Uint8List? image = await AppUtlis.getImageFromGallery(context: context);
    final profileImage = firebaseStorage.ref('profileImage').child('image');
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
