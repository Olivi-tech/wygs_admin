import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/clippers/sign_in_clipper.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  late TextEditingController passWordController;
  GlobalKey<FormState> formField = GlobalKey<FormState>();
  late ValueNotifier<bool> passwordVisibility;
  late ValueNotifier<bool> loading;
  @override
  void initState() {
    emailController = TextEditingController();
    passWordController = TextEditingController();
    emailController.text = "valid@gmail.com";
    passWordController.text = "123456";
    passwordVisibility = ValueNotifier<bool>(true);
    loading = ValueNotifier<bool>(false);

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    passwordVisibility.dispose();
    loading.dispose();
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
                        height: height * 0.2,
                        child: Image.asset(AppImages.guitar),
                      ),
                      SizedBox(height: height * 0.02),
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      const FittedBox(
                        child: Text(
                          'Enter registered email id below to get \nthe magic link for sign in.',
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: AppSize.large,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      SizedBox(
                          height: height * 0.1,
                          width: width * 0.28,
                          child: CustomTextField(
                            controller: emailController,
                            hintText: 'Enter Email ID',
                            hintStyle: const TextStyle(fontSize: AppSize.large),
                            fillColor: AppColor.white,
                            borderColor: AppColor.white,
                            validator: (email) {
                              if (email != null &&
                                  !EmailValidator.validate(email)) {
                                return 'Please enter a valid email';
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
                            borderColor: AppColor.white,
                            isVisibleText: isVisible,
                            hintText: 'Password',
                            obscuringCharacter: '●',
                            hintStyle: const TextStyle(fontSize: AppSize.large),
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
                              if (value.isEmpty) {
                                return 'Please enter a password';
                              } else {
                                return null;
                              }
                            },
                          ),
                          valueListenable: passwordVisibility,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      SizedBox(
                        height: height * 0.08,
                        width: width * 0.28,
                        child: ValueListenableBuilder<bool>(
                          valueListenable: loading,
                          builder: (context, value, child) {
                            return CustomButton(
                              isLoading: value,
                              onPressed: () async {
                                if (formField.currentState!.validate()) {
                                  loading.value = true;

                                  await AuthServices.login(
                                      email: emailController.text,
                                      password: passWordController.text,
                                      context: context);
                                  loading.value = false;
                                }
                              },
                              backgroundColor: AppColor.blue,
                              textColor: AppColor.white,
                              textSize: AppSize.large,
                              text: 'Sign In',
                            );
                          },
                        ),
                      ),
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
