import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/text_form_field.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: CustomContainer(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Image.asset(
                  AppImages.rainbowImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
                top: 40,
                left: 70,
                child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset(AppImages.person))),
            const Positioned(
              top: 110,
              left: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Shakil Awan',
                    color: AppColor.fullBlack,
                    size: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    text: '@Shakil Awan',
                    color: AppColor.lightBlack,
                    size: AppSize.meddium,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            ),
            Positioned(
              top: 155,
              left: 57,
              right: 57,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CustomText(
                        text: 'Change',
                        color: AppColor.blue,
                        size: AppSize.meddium,
                        fontWeight: FontWeight.w400,
                      ),
                      Gap(40),
                      CustomText(
                        text: 'Delete',
                        color: AppColor.red,
                        size: AppSize.meddium,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: CustomText(
                      text: 'Edit Profile',
                      color: AppColor.fullBlack,
                      size: AppSize.large,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const CustomText(
                    text: 'Set up your personal information',
                    color: AppColor.lightBlack,
                    size: AppSize.meddium,
                    fontWeight: FontWeight.w400,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      children: [
                        const CustomText(
                          text: 'Email ID',
                          color: AppColor.fullBlack,
                          size: AppSize.meddium,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(width * 0.3),
                        const CustomText(
                          text: 'Username',
                          color: AppColor.lightBlack,
                          size: AppSize.meddium,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: height * 0.08,
                              width: width * 0.23,
                              child: const CustomTextFormField(
                                hintText: 'username@email.com',
                                fillColor: AppColor.lightSilver,
                                cursorColor: AppColor.white,
                              )),
                        ),
                        const Gap(30),
                        Expanded(
                          child: SizedBox(
                              height: height * 0.08,
                              width: width * 0.23,
                              child: const CustomTextFormField(
                                hintText: '@Shakeel_Awan',
                                fillColor: AppColor.white,
                                cursorColor: AppColor.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      children: [
                        const CustomText(
                          text: 'First Name',
                          color: AppColor.fullBlack,
                          size: AppSize.meddium,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(width * 0.285),
                        const CustomText(
                          text: 'Last Name',
                          color: AppColor.lightBlack,
                          size: AppSize.meddium,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: height * 0.08,
                              width: width * 0.23,
                              child: const CustomTextFormField(
                                hintText: 'Shakeel',
                                fillColor: AppColor.white,
                                cursorColor: AppColor.white,
                              )),
                        ),
                        const Gap(30),
                        Expanded(
                          child: SizedBox(
                              height: height * 0.08,
                              width: width * 0.23,
                              child: const CustomTextFormField(
                                hintText: 'Awan',
                                fillColor: AppColor.white,
                                cursorColor: AppColor.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      children: [
                        const CustomText(
                          text: 'Phone No',
                          color: AppColor.fullBlack,
                          size: AppSize.meddium,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(width * 0.295),
                        const CustomText(
                          text: 'Address',
                          color: AppColor.lightBlack,
                          size: AppSize.meddium,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: height * 0.08,
                              child: const CustomTextFormField(
                                hintText: '',
                                fillColor: AppColor.lightSilver,
                                cursorColor: AppColor.white,
                              )),
                        ),
                        const Gap(30),
                        Expanded(
                          child: SizedBox(
                              height: height * 0.08,
                              child: const CustomTextFormField(
                                hintText: '',
                                fillColor: AppColor.white,
                                cursorColor: AppColor.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                      child: SizedBox(
                        height: height * 0.07,
                        width: width * 0.12,
                        child: CustomButton(
                          onPressed: () {},
                          text: 'SAVE CHANGES',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
