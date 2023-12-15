import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/clippers/sign_in_clipper.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/utlis/app_routes.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController signinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: AppColor.lightSilver,
      body: Row(
        children: [
          ClipPath(
            clipper: SigninClipper(),
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width * 0.5,
                  color: AppColor.white,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: SizedBox(
                        height: height * 0.4,
                        width: width * 0.3,
                        child: SvgPicture.asset(AppSvgs.signin)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColor.lightSilver,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.3,
                      child: Image.asset(AppImages.guitarLogo),
                    ),
                    CustomSize(height: height * 0.02),
                    const CustomText(
                      text: 'Sign in',
                      color: AppColor.fullBlack,
                      size: 36,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomSize(height: height * 0.015),
                    const FittedBox(
                      child: CustomText(
                        text:
                            'Enter registered email id below to get the magic \nlink for sign in.',
                        color: AppColor.fullBlack,
                        size: AppSize.xmeddium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomSize(height: height * 0.03),
                    SizedBox(
                        height: height * 0.1,
                        width: width * 0.28,
                        child: CustomTextField(
                          controller: signinController,
                          hintText: 'Enter Email ID',
                          hintStyle:
                              const TextStyle(fontSize: AppSize.xmeddium),
                          fillColor: AppColor.white,
                          cursorColor: AppColor.white,
                        )),
                    CustomSize(height: height * 0.03),
                    SizedBox(
                        height: height * 0.1,
                        width: width * 0.28,
                        child: CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.progressManagement);
                          },
                          textSize: AppSize.xmeddium,
                          text: 'Generate Magic Link',
                        )),
                    CustomSize(height: height * 0.1),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
