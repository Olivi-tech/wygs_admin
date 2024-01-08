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
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  String imageUrl = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ImagePickerProvider imagePickerProvider;
  Future<AdminModel?> adminDetails =
      AuthServices.fetchAdminDetails().then((adminModel) {
    return adminModel;
  });
  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    Future.delayed(Duration.zero)
        .then((value) => imagePickerProvider.setPath = '');
    AuthServices.fetchAdminDetails().then((adminModel) {
      if (adminModel != null) {
        firstNameController.text = adminModel.firstName!;
        lastNameController.text = adminModel.lastName!;
        addressController.text = adminModel.address!;
        phoneController.text = adminModel.phoneNumber!;
        imageUrl = adminModel.imageUrl!;
     
      } else {
        firstNameController.text = '';
        lastNameController.text = '';
        addressController.text = '';
        phoneController.text = '';
        imageUrl = '';
      }
      return adminModel;
    });

    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    emailController.text = AuthServices.getCurrentUser!.email!;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: formKey,
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
                                      backgroundImage: AssetImage(value.path),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(imageUrl),
                                    ));
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      top: 110,
                      left: 270,
                      child: FutureBuilder(
                        future: adminDetails,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            AdminModel data = snapshot.data!;
                            return CustomText(
                              text:
                                  '${data.firstName ?? ''} ${data.lastName ?? ''}',
                              color: AppColor.black,
                              size: 24,
                              weight: FontWeight.w700,
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      )),
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
                                child: const CustomText(
                                  text: 'Change',
                                  color: AppColor.blue,
                                  size: AppSize.large,
                                  weight: FontWeight.w400,
                                )),
                            const Gap(40),
                            InkWell(
                              onTap: () {
                                imagePickerProvider.deleteImage();
                                AuthServices.deleteImageUrl();
                              },
                              child: const CustomText(
                                text: 'Delete',
                                color: AppColor.red,
                                size: AppSize.large,
                                weight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CustomText(
                              text: 'Edit Profile',
                              color: AppColor.black,
                              size: AppSize.xlarge,
                              weight: FontWeight.w700),
                        ),
                        const CustomText(
                          text: 'Set up your personal information',
                          color: AppColor.indigo,
                          size: AppSize.large,
                          weight: FontWeight.w400,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Row(
                            children: [
                              buildText('Email ID'),
                              Gap(width * 0.3),
                              buildText('First Name'),
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
                                  child: CustomTextField(
                                    borderColor: const Color(0xE5D1D9E6),
                                    controller: emailController,
                                    readOnly: true,
                                    fillColor: AppColor.white,
                                  ),
                                ),
                              ),
                              const Gap(30),
                              Expanded(
                                child: SizedBox(
                                  height: height * 0.1,
                                  width: width * 0.23,
                                  child: CustomTextField(
                                    borderColor: const Color(0xE5D1D9E6),
                                    keyBoardType: TextInputType.name,
                                    controller: firstNameController,
                                    fillColor: AppColor.white,
                                    validator: (value) {
                                      if (value.length < 2) {
                                        return 'Enter correct name';
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
                              buildText('Last Name'),
                              Gap(width * 0.285),
                              buildText('Phone No'),
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
                                    child: CustomTextField(
                                      borderColor: const Color(0xE5D1D9E6),
                                      keyBoardType: TextInputType.name,
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
                              const Gap(30),
                              Expanded(
                                child: SizedBox(
                                    height: height * 0.1,
                                    width: width * 0.23,
                                    child: CustomTextField(
                                      borderColor: const Color(0xE5D1D9E6),
                                      keyBoardType: TextInputType.phone,
                                      controller: phoneController,
                                      fillColor: AppColor.white,
                                      validator: (value) {
                                        bool phoneValid = RegExp(
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                            .hasMatch(value!);
                                        if (!phoneValid) {
                                          return 'Enter valid phone number';
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
                          child: buildText('Address'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: SizedBox(
                            height: height * 0.1,
                            width: width * 0.32,
                            child: CustomTextField(
                              controller: addressController,
                              borderColor: const Color(0xE5D1D9E6),
                              fillColor: AppColor.white,
                              validator: (value) {
                                if (value.length < 2) {
                                  return 'Enter correct address';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                              height: height * 0.07,
                              width: 100,
                              child: CustomButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    String profileImageUrl = context
                                        .read<ImagePickerProvider>()
                                        .path;
                                    toastMessage('Saved Successfully');
                                    AdminModel adminModel = AdminModel(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        phoneNumber: phoneController.text,
                                        address: addressController.text,
                                        imageUrl: profileImageUrl);
                                    await AuthServices.storeAdminDetails(
                                      adminModel: adminModel,
                                    );
                                  }
                                },
                                text: 'SAVE',
                                fixedHeight: height * 0.07,
                                fixedWidth: width * 0.8,
                                backgroundColor: AppColor.blue,
                                textColor: AppColor.white,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
}
