import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
customDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: SvgPicture.asset(
          AppSvgs.danger,
          width: 50,
          height: 60,
        ),
        content: const SizedBox(
          height: 80,
          child: Column(
            children: [
             Text(
               'Are You Sure',
             style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
             ),
              ),
              Text(
                'Are you sure? you want to delete this data.',
               style: TextStyle(
                fontSize: AppSize.meddium,
                color: Colors.black,
                fontWeight: FontWeight.w400,
               ),
              ),
            Text(
              'This cannot be undone.',
               style: TextStyle(
                 fontSize: AppSize.meddium,
                color: Colors.black,
                fontWeight: FontWeight.w400,
               ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: AppColor.black),
                    backgroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child:Text(
                  'Cancel',
                   style: TextStyle(
                    fontSize: AppSize.large,
                    color: AppColor.black,
                    fontWeight: FontWeight.w700,
                   ),
                  )),
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF4B61)),
                    backgroundColor: const Color(0xFFFF4B61),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child: Text(
                  'Delete',
                  style: TextStyle(
                      fontSize: AppSize.large,
                    color: AppColor.white,
                    fontWeight: FontWeight.w700,
                  ),
                  )),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

feedbackDialog(BuildContext context, TextEditingController controller) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        icon: Column(
          children: [
            const Text(
             'Give Feedback',
              style: TextStyle(
                fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              ),
            ),
            const Text(
           'What do you think of these answers?',
           style: TextStyle(
              fontSize: AppSize.meddium,
              color: Colors.black,
              fontWeight: FontWeight.w400,
           ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(AppSvgs.angry),
                  SvgPicture.asset(AppSvgs.frown),
                  SvgPicture.asset(AppSvgs.neutral),
                  SvgPicture.asset(AppSvgs.agree),
                  SvgPicture.asset(AppSvgs.laughing),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 140, top: 10),
              child: Text(
                'User Feedback',
              style: TextStyle(
                  fontSize: AppSize.meddium,
                color: Color(0xFF424D57),
                fontWeight: FontWeight.w600,
              ),
              ),
            ),
          ],
        ),
        title: SizedBox(
          height: 100,
          width: 60,
          child: TextFormField(
            maxLines: null,
            controller: controller,
            expands: true,
            cursorColor: const Color(0xFF6B779A),
            decoration: InputDecoration(
              hintText: 'Write your feedback here',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFF6B779A),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFF6B779A),
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xE5D1D9E6),
                  )),
              hintStyle: const TextStyle(
                fontSize: AppSize.xsmall,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B779A),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: AppColor.black),
                    backgroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child: Text(
                    'Cancel',
                   style: TextStyle(
                   fontSize: AppSize.large,
                    color: AppColor.black,
                    fontWeight: FontWeight.w700,
                   ),
                  )),
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: AppColor.blue),
                    backgroundColor: AppColor.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child:Text(
               'Delete',
                   style: TextStyle(
                     fontSize: AppSize.large,
                    color: AppColor.white,
                    fontWeight: FontWeight.w700,
                   ),
                  )),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
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