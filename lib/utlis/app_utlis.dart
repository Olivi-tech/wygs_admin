import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/widgets/custom_button.dart';
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
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.black,
                  textColor: AppColor.black,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Delete',
                  backgroundColor: const Color(0xFFFF4B61),
                  borderColor: const Color(0xFFFF4B61),
                  textColor: AppColor.white,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
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
        icon: SizedBox(
          height: 150,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: Consumer<ScreenTransitionProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () => value.setEmojiIndex = 0,
                              child: SvgPicture.asset(
                                AppSvgs.angry,
                                width: 40,
                                colorFilter: ColorFilter.mode(
                                    value.getEmojiIndex == 0
                                        ? AppColor.deepAmber
                                        : const Color.fromARGB(
                                            255, 170, 180, 207),
                                    BlendMode.srcOver),
                              )),
                          GestureDetector(
                              onTap: () => value.setEmojiIndex = 1,
                              child: SvgPicture.asset(
                                AppSvgs.frown,
                                width: 40,
                                colorFilter: ColorFilter.mode(
                                    value.getEmojiIndex == 1
                                        ? AppColor.deepAmber
                                        : const Color.fromARGB(
                                            255, 170, 180, 207),
                                    BlendMode.srcOver),
                              )),
                          GestureDetector(
                              onTap: () => value.setEmojiIndex = 2,
                              child: SvgPicture.asset(
                                AppSvgs.neutral,
                                width: 40,
                                colorFilter: ColorFilter.mode(
                                    value.getEmojiIndex == 2
                                        ? AppColor.deepAmber
                                        : const Color.fromARGB(
                                            255, 170, 180, 207),
                                    BlendMode.srcOver),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GestureDetector(
                              onTap: () => value.setEmojiIndex = 3,
                              child: Icon(CupertinoIcons.smiley,
                                  size: 47,
                                  color: value.getEmojiIndex == 3
                                      ? AppColor.deepAmber
                                      : const Color.fromARGB(
                                          255, 170, 180, 207)),
                            ),
                          ),
                          GestureDetector(
                              onTap: () => value.setEmojiIndex = 4,
                              child: SvgPicture.asset(
                                AppSvgs.laughing,
                                width: 40,
                                colorFilter: ColorFilter.mode(
                                    value.getEmojiIndex == 4
                                        ? AppColor.deepAmber
                                        : const Color.fromARGB(
                                            255, 170, 180, 207),
                                    BlendMode.srcOver),
                              )),
                        ],
                      );
                    },
                  )),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'User Feedback',
                    style: TextStyle(
                      fontSize: AppSize.meddium,
                      color: Color(0xFF424D57),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: TextFormField(
          cursorHeight: 20,
          maxLines: 5,
          controller: controller,
          cursorColor: const Color(0xFF6B779A),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10, top: 20),
            hintText: 'Write your feedback here',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF6B779A),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF6B779A),
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xE5D1D9E6),
                )),
            hintStyle: const TextStyle(
              fontSize: AppSize.xsmall,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B779A),
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
                width: 150,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.black,
                  textColor: AppColor.black,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 150,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Submit',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
                  textColor: AppColor.white,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
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
      return DefaultTabController(
        animationDuration: Duration.zero,
        length: 7,
        child: AlertDialog(
          backgroundColor: AppColor.white,
          content: SizedBox(
            width: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  indicator: const BoxDecoration(
                      color: AppColor.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  labelStyle: const TextStyle(
                      color: AppColor.white,
                      fontSize: AppSize.meddium,
                      fontWeight: FontWeight.w600),
                  unselectedLabelStyle: const TextStyle(
                      color: AppColor.black,
                      fontSize: AppSize.meddium,
                      fontWeight: FontWeight.w600),
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  tabs: <Widget>[
                    Tab(
                      child: buildContainer(
                        'Day 01',
                      ),
                    ),
                    Tab(
                      child: buildContainer(
                        'Day 02',
                      ),
                    ),
                    Tab(
                      child: buildContainer('Day 03'),
                    ),
                    Tab(
                      child: buildContainer(
                        'Day 04',
                      ),
                    ),
                    Tab(
                      child: buildContainer(
                        'Day 05',
                      ),
                    ),
                    Tab(
                      child: buildContainer(
                        'Day 06',
                      ),
                    ),
                    Tab(
                      child: buildContainer(
                        'Day 07',
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Expanded(
                  child: TabBarView(
                    children: [
                      buildTabViewContent(),
                      buildTabViewContent(),
                      buildTabViewContent(),
                      buildTabViewContent(),
                      buildTabViewContent(),
                      buildTabViewContent(),
                      buildTabViewContent(),
                    ],
                  ),
                ),
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
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Reject',
                    backgroundColor: AppColor.white,
                    borderColor: AppColor.red,
                    textColor: AppColor.red,
                    textSize: AppSize.large,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 110,
                  child: CustomButton(
                    onPressed: () {
                      feedbackDialog(context, controller);
                    },
                    text: 'Pass',
                    backgroundColor: AppColor.blue,
                    borderColor: AppColor.blue,
                    textColor: AppColor.white,
                    textSize: AppSize.large,
                    weight: FontWeight.w700,
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

Widget buildTabViewContent() {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
  );
}

Widget buildContainer(
  String days,
) {
  return SizedBox(
    height: 50,
    child: Center(
      child: Text(
        days,
        style: const TextStyle(
          fontSize: AppSize.meddium,
          fontWeight: FontWeight.w600,
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
