import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/firestore_services.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

feedbackDialog(BuildContext context, TextEditingController controller) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        icon: SizedBox(
          height: 200,
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
        title: SizedBox(
          width: 500,
          height: 200,
          child: TextFormField(
            cursorHeight: 20,
            maxLines: 10,
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

customDialog({required BuildContext context, required String userId}) {
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
                    FirestoreServices.deleteProgressUserData(userId)
                        .then((value) {
                      toastMessage('Data Deleted Successfully');
                      Navigator.pop(context);
                    });
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
