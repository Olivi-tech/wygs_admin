import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 01',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 02',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 03',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 04',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 05',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 06',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomContainer(
                  height: height * 0.06,
                  width: width * 0.07,
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
                  child: const Center(
                    child: CustomText(
                      text: 'Day 07',
                      color: AppColor.black,
                      size: AppSize.meddium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.05),
            const CustomText(
                color: AppColor.black,
                size: AppSize.meddium,
                fontWeight: FontWeight.w600,
                text:
                    '1.  “Please jot down a first line for your song. Do not over think this step - just go for it. (*this line will change many times this \n      week, but the rest of your song will be easier to write if you can tell yourself you have a solid first line, tempo, and tone/feel\n      for your song to at least work with for now.)”'),
            SizedBox(height: height * 0.02),
            const CustomText(
              text:
                  '      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              color: AppColor.black,
              size: AppSize.meddium,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: height * 0.02),
            const CustomText(
                color: AppColor.black,
                size: AppSize.meddium,
                fontWeight: FontWeight.w600,
                text:
                    '2.  “Now try to jot down 2 ideas about the song that involve: character and theme. Do not over think. Responses can always \n      be revised.”'),
            SizedBox(height: height * 0.02),
            const CustomText(
              text:
                  '      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              color: AppColor.black,
              size: AppSize.meddium,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: height * 0.02),
            const CustomText(
                color: AppColor.black,
                size: AppSize.meddium,
                fontWeight: FontWeight.w600,
                text:
                    '3.  “Please jot down a first line for your song. Do not over think this step - just go for it. (*this line will change many times this \n      week, but the rest of your song will be easier to write if you can tell yourself you have a solid first line, tempo, and tone/feel\n       for your song to at least work with for now.)”'),
            SizedBox(height: height * 0.02),
            const CustomText(
              text:
                  '      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              color: AppColor.black,
              size: AppSize.meddium,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: height * 0.02),
            const CustomText(
                color: AppColor.black,
                size: AppSize.meddium,
                fontWeight: FontWeight.w600,
                text:
                    '4.  “Now try to jot down 2 ideas about the song that involve: character and theme. Do not over think. Responses can always \n      be revised.”'),
            SizedBox(height: height * 0.02),
            const CustomText(
              text:
                  '      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              color: AppColor.black,
              size: AppSize.meddium,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomContainer(
                    height: height * 0.07,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.red)),
                    child: const Center(
                      child: CustomText(
                        text: 'Reject',
                        color: AppColor.red,
                        size: AppSize.meddium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomContainer(
                    height: height * 0.07,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.blue)),
                    child: const Center(
                      child: CustomText(
                        text: 'Pass',
                        color: AppColor.white,
                        size: AppSize.meddium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
    
  }
  
}
