import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/clippers/sign_in_clipper.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/utlis/passwors_validator.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  GlobalKey<FormState> formField = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }

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
                child: Form(
                  key: formField,
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
                            controller: emailController,
                            hintText: 'Enter Email ID',
                            hintStyle:
                                const TextStyle(fontSize: AppSize.xmeddium),
                            fillColor: AppColor.white,
                            validator: (email) {
                              if (email != null &&
                                  !EmailValidator.validate(email)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          )),
                      CustomSize(height: height * 0.03),
                      SizedBox(
                          height: height * 0.1,
                          width: width * 0.28,
                          child: CustomTextField(
                            controller: passWordController,
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(fontSize: AppSize.xmeddium),
                            fillColor: AppColor.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              } else if (passWordController.text.length <= 4) {
                                return 'Password is too short';
                              } else {
                                bool result =
                                    Validation.validatePassword(value);
                                if (result) {
                                  return null;
                                } else {
                                  return null;
                                }
                              }
                            },
                          )),
                      CustomSize(height: height * 0.03),
                      SizedBox(
                          height: height * 0.1,
                          width: width * 0.28,
                          child: CustomButton(
                            onPressed: () {
                              if (formField.currentState!.validate()) {
                                AuthServices.login(
                                    email: emailController.text,
                                    password: passWordController.text,
                                    context: context);
                                AuthServices.admin(
                                    email: emailController.text,
                                    controller: emailController,
                                    password: passWordController.text);
                              }
                            },
                            textSize: AppSize.xmeddium,
                            text: 'Generate Magic Link',
                          )),
                      CustomSize(height: height * 0.1),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
