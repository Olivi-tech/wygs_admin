import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  Future<Map<String, dynamic>> adminData =
      AuthServices.fetchAdminData().then((value) => value);

  late Future<AdminModel?> adminDetails;

  @override
  void initState() {
    adminDetails = AuthServices.fetchAdminDetails().then((adminModel) {
      return adminModel;
    });
    emailController = TextEditingController();
    usernameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
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
      child: FutureBuilder<AdminModel?>(
          future: adminDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CupertinoActivityIndicator(
                color: AppColor.blue,
              ));
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return SingleChildScrollView(
                child: CustomContainer(
                  height: height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Image.asset(
                            AppImages.rainbow,
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
                              color: AppColor.black,
                              size: 24,
                              fontWeight: FontWeight.w700,
                            ),
                            CustomText(
                              text: '@Shakil Awan',
                              color: AppColor.indigo,
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
                                color: AppColor.black,
                                size: AppSize.large,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const CustomText(
                              text: 'Set up your personal information',
                              color: AppColor.indigo,
                              size: AppSize.meddium,
                              fontWeight: FontWeight.w400,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                children: [
                                  const CustomText(
                                    text: 'Email ID',
                                    color: AppColor.black,
                                    size: AppSize.meddium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Gap(width * 0.3),
                                  const CustomText(
                                    text: 'Username',
                                    color: AppColor.indigo,
                                    size: AppSize.meddium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                        height: height * 0.1,
                                        width: width * 0.23,
                                        child: FutureBuilder(
                                          future: adminData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              Map<String, dynamic> data =
                                                  snapshot.data
                                                      as Map<String, dynamic>;
                                              return CustomTextFormField(
                                                controller: emailController,
                                                readOnly: true,
                                                hintText: data['email'],
                                                fillColor: AppColor.white,
                                                validator: (email) {
                                                  if (email != null &&
                                                      !EmailValidator.validate(
                                                          email)) {
                                                    return 'Enter a valid email';
                                                  }
                                                  return null;
                                                },
                                              );
                                            } else {
                                              return const Text('');
                                            }
                                          },
                                        )),
                                  ),
                                  const Gap(30),
                                  Expanded(
                                    child: SizedBox(
                                      height: height * 0.1,
                                      width: width * 0.23,
                                      child: CustomTextFormField(
                                        keyBoardType: TextInputType.name,
                                        hintText: data!.userName,
                                        controller: usernameController,
                                        fillColor: AppColor.white,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter a username';
                                          } else if (value.length < 3) {
                                            return 'Username must be at least 3 characters long';
                                          } else {
                                            return null;
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
                                    color: AppColor.black,
                                    size: AppSize.meddium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Gap(width * 0.285),
                                  const CustomText(
                                    text: 'Last Name',
                                    color: AppColor.indigo,
                                    size: AppSize.meddium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                        height: height * 0.1,
                                        width: width * 0.23,
                                        child: CustomTextFormField(
                                          keyBoardType: TextInputType.name,
                                          hintText:
                                              data.fullName?.split(' ')[0],
                                          controller: firstNameController,
                                          fillColor: AppColor.white,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter correct name';
                                            } else if (value.length < 2) {
                                              return 'Enter correct name';
                                            } else {
                                              return null;
                                            }
                                          },
                                        )),
                                  ),
                                  const Gap(30),
                                  Expanded(
                                    child: SizedBox(
                                        height: height * 0.1,
                                        width: width * 0.23,
                                        child: CustomTextFormField(
                                          keyBoardType: TextInputType.name,
                                          hintText:
                                              data.fullName!.split(' ')[1],
                                          controller: lastNameController,
                                          fillColor: AppColor.white,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter correct name';
                                            } else if (value.length < 3) {
                                              return 'Enter correct name';
                                            } else {
                                              return null;
                                            }
                                          },
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
                                    color: AppColor.black,
                                    size: AppSize.meddium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Gap(width * 0.295),
                                  const CustomText(
                                    text: 'Address',
                                    color: AppColor.indigo,
                                    size: AppSize.meddium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                        height: height * 0.1,
                                        child: CustomTextFormField(
                                          keyBoardType: TextInputType.phone,
                                          controller: phoneController,
                                          hintText: data.phoneNumber ?? '',
                                          fillColor: AppColor.white,
                                          validator: (value) {
                                            bool phoneValid = RegExp(
                                                    r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                                .hasMatch(value!);
                                            if (value.isEmpty) {
                                              return 'Enter phone number';
                                            } else if (!phoneValid &&
                                                phoneController.text.length !=
                                                    11) {
                                              return 'Enter valid phone number';
                                            }
                                            return null;
                                          },
                                        )),
                                  ),
                                  const Gap(30),
                                  Expanded(
                                    child: SizedBox(
                                        height: height * 0.1,
                                        child: CustomTextFormField(
                                          hintText: data.address ?? '',
                                          controller: addressController,
                                          fillColor: AppColor.white,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter correct address';
                                            } else if (value.length < 2) {
                                              return 'Enter correct address';
                                            } else {
                                              return null;
                                            }
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: height * 0.07,
                                width: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize:
                                          Size(width * 0.9, height * 0.07),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: AppColor.blue),
                                  onPressed: () async {
                                    Utlis().toastMessage('Saved Successfully');
                                    AdminModel adminModel = AdminModel(
                                      userName: usernameController.text,
                                      address: addressController.text,
                                      fullName:
                                          '${firstNameController.text} ${lastNameController.text}',
                                      phoneNumber: phoneController.text,
                                    );
                                    AuthServices.storeAdminDetails(
                                        adminModel: adminModel);

                                    setState(() {});
                                  },
                                  child: const Center(
                                    child: Text(
                                      'SAVE',
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
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Text('');
            }
          }),
    );
  }
}
