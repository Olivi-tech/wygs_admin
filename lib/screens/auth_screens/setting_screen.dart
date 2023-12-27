import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
  late ImagePickerProvider imagePickerProvider;

  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    Future.delayed(Duration.zero)
        .then((value) => imagePickerProvider.setPath = '');
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
                child: Container(
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
                            child: Consumer<ImagePickerProvider>(
                              builder: (context, value, child) {
                                return SizedBox(
                                  child: value.path.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(value.path),
                                        )
                                      : Image.asset(AppImages.person),
                                );
                              },
                            )),
                      ),
                      Positioned(
                        top: 110,
                        left: 270,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            nameText(),
                            buildText('@Shakil Awan'),
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
                                    onTap: () {
                                      AppUtlis.storeImageToFirebase(context);
                                    },
                                    child: changeText('Change', true)),
                                const Gap(40),
                                InkWell(
                                  onTap: () {
                                    imagePickerProvider.deleteImage();
                                  },
                                  child: changeText('Delete', false),
                                )
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: editText('Edit Profile', true)),
                            editText('Set up your personal information', false),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                children: [
                                  buildText('Email ID'),
                                  Gap(width * 0.3),
                                  buildText('Username'),
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
                                                hintText: data['email'] ?? '',
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
                                        hintText: data!.userName ?? '',
                                        controller: usernameController,
                                        fillColor: AppColor.white,
                                        validator: (value) {
                                          if (value.length < 2) {
                                            return 'Enter a username';
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
                                  buildText('First Name'),
                                  Gap(width * 0.285),
                                  buildText('Last Name'),
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
                                          hintText: data.firstName ?? '',
                                          controller: firstNameController,
                                          fillColor: AppColor.white,
                                          validator: (value) {
                                            if (value.length < 2) {
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
                                          hintText: data.lastName ?? '',
                                          controller: lastNameController,
                                          fillColor: AppColor.white,
                                          validator: (value) {
                                            if (value.length < 2) {
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
                                  buildText('Phone No'),
                                  Gap(width * 0.285),
                                  buildText('Address'),
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
                                            if (!phoneValid &&
                                                phoneController.text.length !=
                                                    11) {
                                              return 'Enter valid phone number';
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
                                    toastMessage('Saved Successfully');

                                    AdminModel adminModel = AdminModel(
                                        userName:
                                            usernameController.text.isEmpty
                                                ? data.userName
                                                : usernameController.text,
                                        address: addressController.text.isEmpty
                                            ? data.address
                                            : addressController.text,
                                        firstName:
                                            firstNameController.text.isEmpty
                                                ? data.firstName
                                                : firstNameController.text,
                                        lastName:
                                            lastNameController.text.isEmpty
                                                ? data.lastName
                                                : lastNameController.text,
                                        phoneNumber:
                                            phoneController.text.isEmpty
                                                ? data.phoneNumber
                                                : phoneController.text);
                                    AuthServices.updateAdminDetails(
                                        adminModel: adminModel);
                                    AuthServices.storeAdminDetails(
                                        adminModel: adminModel);
                                  },
                                  child: const Center(
                                    child: Text(
                                      'SAVE',
                                      style: TextStyle(
                                          fontSize: AppSize.large,
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
              return SingleChildScrollView(
                child: Container(
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
                            child: GestureDetector(
                              child: Consumer<ImagePickerProvider>(
                                builder: (context, value, child) {
                                  return SizedBox(
                                    child: value.path.isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(value.path),
                                          )
                                        : Image.asset(AppImages.person),
                                  );
                                },
                              ),
                            )),
                      ),
                      Positioned(
                        top: 110,
                        left: 270,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            nameText(),
                            buildText('@Shakil Awan'),
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
                                  onTap: () {
                                    AppUtlis.storeImageToFirebase(context);
                                  },
                                  child: changeText('Change', true),
                                ),
                                const Gap(40),
                                InkWell(
                                    onTap: () {
                                      imagePickerProvider.deleteImage();
                                    },
                                    child: changeText('Delete', false))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: editText('Edit Profile', true),
                            ),
                            editText('Set up your personal information', false),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                children: [
                                  buildText('Email ID'),
                                  Gap(width * 0.3),
                                  buildText('Username'),
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
                                        controller: emailController,
                                        readOnly: true,
                                        hintText: '',
                                        fillColor: AppColor.white,
                                        validator: (email) {
                                          if (email != null &&
                                              !EmailValidator.validate(email)) {
                                            return 'Enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const Gap(30),
                                  Expanded(
                                    child: SizedBox(
                                      height: height * 0.1,
                                      width: width * 0.23,
                                      child: CustomTextFormField(
                                        keyBoardType: TextInputType.name,
                                        hintText: '',
                                        controller: usernameController,
                                        fillColor: AppColor.white,
                                        validator: (value) {
                                          if (value.length < 3) {
                                            return 'Enter a username';
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
                                  buildText('First Name'),
                                  Gap(width * 0.285),
                                  buildText('Last Name'),
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
                                          hintText: '',
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
                                          hintText: '',
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
                                  buildText('Phone No'),
                                  Gap(width * 0.295),
                                  buildText('Address'),
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
                                          hintText: '',
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
                                          hintText: '',
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
                                    toastMessage('Saved Successfully');

                                    AdminModel adminModel = AdminModel(
                                        userName: usernameController.text,
                                        address: addressController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        phoneNumber: phoneController.text);

                                    AuthServices.storeAdminDetails(
                                        adminModel: adminModel);
                                  },
                                  child: Center(
                                    child: saveText('Save'),
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
          }),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColor.indigo,
        fontSize: AppSize.large,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget nameText() {
    return const Text(
      'Shakil Awan',
      style: TextStyle(
        color: AppColor.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget changeText(String text, bool isChange) {
    return Text(
      text,
      style: TextStyle(
        color: isChange ? AppColor.blue : AppColor.red,
        fontSize: AppSize.large,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget editText(String text, bool isChange) {
    return Text(
      text,
      style: TextStyle(
        color: isChange ? AppColor.black : AppColor.indigo,
        fontSize: isChange ? AppSize.xlarge : AppSize.large,
        fontWeight: isChange ? FontWeight.w700 : FontWeight.w400,
      ),
    );
  }

  Widget saveText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: AppSize.large,
          fontWeight: FontWeight.w600,
          color: AppColor.white),
    );
  }
}