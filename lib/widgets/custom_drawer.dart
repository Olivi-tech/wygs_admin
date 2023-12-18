import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/provider/screen_transition_provider.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ScreenTransitionProvider screenTransitionProvider;

  @override
  void initState() {
    super.initState();
    screenTransitionProvider =
        Provider.of<ScreenTransitionProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;

    return Consumer<ScreenTransitionProvider>(
        builder: (context, providerIndex, child) {
      return Container(
        height: height,
        width: 230,
        decoration: BoxDecoration(
            color: AppColor.white, border: Border.all(color: AppColor.black)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppImages.guitarLogo),
                const Divider(
                  height: 8,
                  thickness: 1,
                  indent: 2,
                  endIndent: 2,
                ),
                CustomSize(height: height * 0.04),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 0;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 0
                        ? AppColor.white
                        : AppColor.blue,
                    bgColor: providerIndex.getIndex == 0
                        ? AppColor.blue
                        : AppColor.white,
                    textColor: providerIndex.getIndex == 0
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.chartBar,
                    text: 'Progress Management',
                  ),
                ),
                CustomSize(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 1;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    bgColor: providerIndex.getIndex == 1
                        ? AppColor.blue
                        : AppColor.white,
                    iconColor: providerIndex.getIndex == 1
                        ? AppColor.white
                        : AppColor.blue,
                    textColor: providerIndex.getIndex == 1
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.chartOutline,
                    text: 'Community Management',
                  ),
                ),
                CustomSize(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 2;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 2
                        ? AppColor.white
                        : AppColor.blue,
                    bgColor: providerIndex.getIndex == 2
                        ? AppColor.blue
                        : AppColor.white,
                    textColor: providerIndex.getIndex == 2
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.guest,
                    text: 'Guest Management',
                  ),
                ),
                CustomSize(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 3;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 3
                        ? AppColor.white
                        : AppColor.blue,
                    textColor: providerIndex.getIndex == 3
                        ? AppColor.white
                        : AppColor.blue,
                    bgColor: providerIndex.getIndex == 3
                        ? AppColor.blue
                        : AppColor.white,
                    iconPath: AppSvgs.bill,
                    text: 'Billing Management',
                  ),
                ),
                CustomSize(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 4;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    bgColor: providerIndex.getIndex == 4
                        ? AppColor.blue
                        : AppColor.white,
                    iconColor: providerIndex.getIndex == 4
                        ? AppColor.white
                        : AppColor.blue,
                    textColor: providerIndex.getIndex == 4
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.settings,
                    text: 'Settings',
                  ),
                ),
                CustomSize(height: height * 0.15),
                InkWell(
                  onTap: () {
                  FirebaseAuth.instance.signOut();
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    iconColor: AppColor.lightRed,
                    textColor: AppColor.lightRed,
                    iconPath: AppSvgs.logout,
                    text: 'Logout',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildCustomContainer({
    required double height,
    Color? bgColor,
    required String iconPath,
    required Color iconColor,
    required String text,
    required Color textColor,
  }) {
    return CustomContainer(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomText(
              text: text,
              color: textColor,
              size: AppSize.xmeddium,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
