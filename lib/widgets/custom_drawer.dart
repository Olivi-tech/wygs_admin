import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;

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
              buildCustomContainer(
                height: height * 0.07,
                bgColor: AppColor.blue,
                iconColor: AppColor.white,
                textColor: AppColor.white,
                iconPath: AppSvgs.chartBar,
                text: 'Progress Management',
              ),
              CustomSize(height: height * 0.015),
              buildCustomContainer(
                height: height * 0.07,
                bgColor: AppColor.white,
                iconColor: AppColor.blue,
                textColor: AppColor.blue,
                iconPath: AppSvgs.chartOutline,
                text: 'Community Management',
              ),
              CustomSize(height: height * 0.015),
              buildCustomContainer(
                height: height * 0.07,
                bgColor: AppColor.white,
                iconColor: AppColor.blue,
                textColor: AppColor.blue,
                iconPath: AppSvgs.guest,
                text: 'Guest Management',
              ),
              CustomSize(height: height * 0.015),
              buildCustomContainer(
                height: height * 0.07,
                bgColor: AppColor.white,
                iconColor: AppColor.blue,
                textColor: AppColor.blue,
                iconPath: AppSvgs.bill,
                text: 'Billing Management',
              ),
              CustomSize(height: height * 0.015),
              buildCustomContainer(
                height: height * 0.07,
                bgColor: AppColor.white,
                iconColor: AppColor.blue,
                textColor: AppColor.blue,
                iconPath: AppSvgs.settings,
                text: 'Settings',
              ),
              CustomSize(height: height * 0.15),
              buildCustomContainer(
                height: height * 0.07,
                bgColor: AppColor.white,
                iconColor: AppColor.lightRed,
                textColor: AppColor.lightRed,
                iconPath: AppSvgs.logout,
                text: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomContainer({
    required double height,
    required Color bgColor,
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
