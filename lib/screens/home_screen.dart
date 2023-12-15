import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/screens/screens.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerVisible = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    if (width < 1100) {
      isDrawerVisible = false;
    } else {
      isDrawerVisible = true;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.lightSilver,
        body: Row(
          children: [
            Visibility(
              visible: isDrawerVisible,
              child: const CustomDrawer(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomContainer(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                          color: AppColor.black,
                        ),
                      ),
                      height: height * 0.1,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: CustomText(
                              text: 'Admin Panel',
                              color: Color(0xFF424D57),
                              size: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomContainer(
                                  decoration: BoxDecoration(
                                      color: const Color(0x190174BE),
                                      borderRadius: BorderRadius.circular(100)),
                                  height: height * 0.07,
                                  width: 40,
                                  child: const Center(
                                    child: CustomText(
                                      text: 'SA',
                                      color: Color(0xFF0174BE),
                                      size: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: CustomText(
                                  text: 'Shakeel Awan',
                                  color: Color(0xFF0C356A),
                                  size: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    CustomSize(height: height * 0.05),
                    const SettingScreen()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
