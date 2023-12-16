import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/auth_services.dart';
import 'package:guitar_songs/widgets/text_form_field.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  GlobalKey<FormState> formField = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    return await FirebaseFirestore.instance.collection('adminDetails').get();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

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
              child: Form(
                key: formField,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const CustomText(
                            text: 'Change',
                            color: AppColor.blue,
                            size: AppSize.meddium,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Gap(40),
                        InkWell(
                          onTap: () {},
                          child: const CustomText(
                            text: 'Delete',
                            color: AppColor.red,
                            size: AppSize.meddium,
                            fontWeight: FontWeight.w400,
                          ),
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
                              height: height * 0.1,
                              width: width * 0.23,
                              child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                future: getData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return CustomTextFormField(
                                      controller: emailController,
                                      hintText: data.first['email'],
                                      fillColor: AppColor.white,
                                      validator: (email) {
                                        if (email != null &&
                                            !EmailValidator.validate(email)) {
                                          return 'Enter a valid email';
                                        }
                                        return null;
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                          const Gap(30),
                          Expanded(
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.23,
                              child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                future: getData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return CustomTextFormField(
                                      keyBoardType: TextInputType.name,
                                      hintText: data.first['username'],
                                      controller: usernameController,
                                      fillColor: AppColor.white,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter correct username';
                                        } else {
                                          return null;
                                        }
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
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
                              height: height * 0.1,
                              width: width * 0.23,
                              child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                future: getData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return CustomTextFormField(
                                      keyBoardType: TextInputType.name,
                                      hintText: data.first['firstName'],
                                      controller: firstNameController,
                                      fillColor: AppColor.white,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter correct name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                          const Gap(30),
                          Expanded(
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.23,
                              child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                future: getData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return CustomTextFormField(
                                      keyBoardType: TextInputType.name,
                                      hintText: data.first['lastName'],
                                      controller: lastNameController,
                                      fillColor: AppColor.white,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter correct name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
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
                              height: height * 0.1,
                              child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                future: getData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return CustomTextFormField(
                                      keyBoardType: TextInputType.phone,
                                      controller: addressController,
                                      hintText: data.first['address'],
                                      fillColor: AppColor.white,
                                      validator: (value) {
                                        bool phoneValid = RegExp(
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                            .hasMatch(value!);
                                        if (value.isEmpty) {
                                          return 'Enter phone number';
                                        } else if (!phoneValid &&
                                            phoneController.text.length != 11) {
                                          return 'Enter valid phone number';
                                        }
                                        return null;
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                          const Gap(30),
                          Expanded(
                            child: SizedBox(
                              height: height * 0.1,
                              child: FutureBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                future: getData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data!.docs;
                                    return CustomTextFormField(
                                      keyBoardType: TextInputType.name,
                                      hintText: data.first['lastName'],
                                      controller: addressController,
                                      fillColor: AppColor.white,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter correct name';
                                        } else {
                                          return null;
                                        }
                                      },
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SizedBox(
                          height: height * 0.07,
                          width: width * 0.12,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(width * 0.9, height * 0.07),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColor.blue),
                            onPressed: () {
                              if (formField.currentState!.validate()) {
                                AuthServices.adminData(
                                    email: emailController.text,
                                    controller: emailController,
                                    username: usernameController.text,
                                    lastName: lastNameController.text,
                                    firstName: firstNameController.text,
                                    phoneNo: phoneController.text,
                                    address: addressController.text);
                              }
                            },
                            child: const Text(
                              'SAVE CHANGES',
                              style: TextStyle(
                                  fontSize: AppSize.xmeddium,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
