// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/utlis/app_routes.dart';
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
    final double width = size.width;
    return Consumer<ScreenTransitionProvider>(
        builder: (context, providerIndex, child) {
      return Container(
        height: height,
        width: 250,
        decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.jetBlack)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: height * 0.13,
                    width: width * 0.13,
                    child: Image.asset(AppImages.guitar)),
                SizedBox(height: height * 0.04),
                const Divider(
                  height: 8,
                  thickness: 1,
                  indent: 2,
                  endIndent: 2,
                ),
                SizedBox(height: height * 0.04),
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
                SizedBox(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 1;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 1
                        ? AppColor.white
                        : AppColor.blue,
                    bgColor: providerIndex.getIndex == 1
                        ? AppColor.blue
                        : AppColor.white,
                    textColor: providerIndex.getIndex == 1
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.userLinear,
                    text: 'User Management',
                  ),
                ),
                SizedBox(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 2;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    bgColor: providerIndex.getIndex == 2
                        ? AppColor.blue
                        : AppColor.white,
                    iconColor: providerIndex.getIndex == 2
                        ? AppColor.white
                        : AppColor.blue,
                    textColor: providerIndex.getIndex == 2
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.chartOutline,
                    text: 'Community Management',
                  ),
                ),
                SizedBox(height: height * 0.015),
                // InkWell(
                //   onTap: () {
                //     screenTransitionProvider.setIndex = 3;
                //   },
                //   child: buildCustomContainer(
                //     height: height * 0.07,
                //     iconColor: providerIndex.getIndex == 3
                //         ? AppColor.white
                //         : AppColor.blue,
                //     bgColor: providerIndex.getIndex == 3
                //         ? AppColor.blue
                //         : AppColor.white,
                //     textColor: providerIndex.getIndex == 3
                //         ? AppColor.white
                //         : AppColor.blue,
                //     iconPath: AppSvgs.guest,
                //     text: 'Guest Management',
                //   ),
                // ),
                //  SizedBox(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 4;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    iconColor: providerIndex.getIndex == 4
                        ? AppColor.white
                        : AppColor.blue,
                    textColor: providerIndex.getIndex == 4
                        ? AppColor.white
                        : AppColor.blue,
                    bgColor: providerIndex.getIndex == 4
                        ? AppColor.blue
                        : AppColor.white,
                    iconPath: AppSvgs.bill,
                    text: 'Billing Management',
                  ),
                ),
                SizedBox(height: height * 0.015),
                InkWell(
                  onTap: () {
                    screenTransitionProvider.setIndex = 5;
                  },
                  child: buildCustomContainer(
                    height: height * 0.07,
                    bgColor: providerIndex.getIndex == 5
                        ? AppColor.blue
                        : AppColor.white,
                    iconColor: providerIndex.getIndex == 5
                        ? AppColor.white
                        : AppColor.blue,
                    textColor: providerIndex.getIndex == 5
                        ? AppColor.white
                        : AppColor.blue,
                    iconPath: AppSvgs.settings,
                    text: 'Settings',
                  ),
                ),
                SizedBox(height: height * 0.15),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.signin, (route) => false);
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
              size: AppSize.large,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
