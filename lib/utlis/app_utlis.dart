import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
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
                      child: Text(
                    'Submit',
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

questionDialog(BuildContext context, TextEditingController controller) {
  return showDialog(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: AppColor.white,
          icon: SizedBox(
            width: 800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer('Day 01'),
                    buildContainer('Day 02'),
                    buildContainer('Day 03'),
                    buildContainer('Day 04'),
                    buildContainer('Day 05'),
                    buildContainer('Day 06'),
                    buildContainer('Day 07'),
                  ],
                ),
                const Gap(15),
                buildQuestionText(
                    '1.“Please jot down a first line for your song. Do not over think this step - just go for it. (*this line will change many times this week, but the rest of your song will be easier to write if you can tell yourself you have a solid first line, tempo, and tone/feel for your song to at least work with for now.)”'),
                buildAnswerText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                buildQuestionText(
                    '2.“Now try to jot down 2 ideas about the song that involve: character and theme. Do not over think. Responses can always be revised.”'),
                buildAnswerText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
                buildQuestionText(
                    '3.“Please jot down a first line for your song. Do not over think this step - just go for it. (*this line will change many times this week, but the rest of your song will be easier to write if you can tell yourself you have a solid first line, tempo, and tone/feel\n for your song to at least work with for now.)”'),
                buildAnswerText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: AppColor.red),
                      backgroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: AppSize.meddium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                      feedbackDialog(context, controller);
                    },
                    child: const Center(
                      child: Text(
                        'Pass',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: AppSize.meddium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget buildContainer(String text) {
  return Flexible(
    child: Container(
      height: 50,
      width: 90,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x23000000),
              blurRadius: 17,
              offset: Offset(0, 6),
              spreadRadius: 2,
            )
          ]),
      child: Center(
        child: Text(
          text,
          softWrap: true,
          style: const TextStyle(
            color: AppColor.black,
            fontSize: AppSize.meddium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Widget buildQuestionText(String question) {
  return Text(
    question,
    style: const TextStyle(
      color: AppColor.black,
      fontSize: AppSize.meddium,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget buildAnswerText(String answer) {
  return Text(
    answer,
    style: const TextStyle(
      color: AppColor.black,
      fontSize: AppSize.meddium,
      fontWeight: FontWeight.w400,
    ),
  );
}
