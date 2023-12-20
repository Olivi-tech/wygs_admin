import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/clippers/sign_in_clipper.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  TextEditingController passWordController = TextEditingController();
  GlobalKey<FormState> formField = GlobalKey<FormState>();
  late ValueNotifier<bool> passwordVisibility;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordVisibility = ValueNotifier<bool>(true);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    passwordVisibility.dispose();
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
                                      SizedBox(height: height * 0.02),
                      const CustomText(
                        text: 'Sign in',
                        color: AppColor.black,
                        size: 36,
                        fontWeight: FontWeight.w700,
                      ),
                                      SizedBox(height: height * 0.015),
                      const FittedBox(
                        child: CustomText(
                          text:
                              'Enter registered email id below to get \nthe magic link for sign in.',
                          color: AppColor.black,
                          size: AppSize.xmeddium,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                                      SizedBox(height: height * 0.03),
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
                                      SizedBox(height: height * 0.03),
                      SizedBox(
                        height: height * 0.1,
                        width: width * 0.28,
                        child: ValueListenableBuilder<bool>(
                          builder: (context, isVisible, child) =>
                              CustomTextField(
                            fillColor: AppColor.white,
                            isVisibleText: isVisible,
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(fontSize: AppSize.xmeddium),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                passwordVisibility.value =
                                    !passwordVisibility.value;
                              },
                              child: Icon(
                                isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            controller: passWordController,
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
                          ),
                          valueListenable: passwordVisibility,
                        ),
                      ),
                                      SizedBox(height: height * 0.03),
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

                                bool? loginSuccess;

                                // ignore: unnecessary_null_comparison
                                if (loginSuccess != null) {
                                  AuthServices.storeAdminData(
                                    email: emailController.text,
                                    controller: emailController.text,
                                  );

                                  emailController.clear();
                                  passWordController.clear();

                                  FocusScope.of(context).unfocus();
                                } else {}
                              }
                            },
                            textSize: AppSize.xmeddium,
                            text: 'Sign In',
                          )),
                                      SizedBox(height: height * 0.1),
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
