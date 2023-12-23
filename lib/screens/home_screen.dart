import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/screens/screens.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerVisible = true;
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomContainer(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(
                        color: AppColor.jetBlack,
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
                              padding: const EdgeInsets.only(right: 30),
                              child: SizedBox(
                                width: width * 0.17,
                                height: height * 0.07,
                                child: CustomTextFormField(
                                  hintText: 'Search here',
                                  controller: searchController,
                                  onChanged: (value) {},
                                  fillColor: AppColor.white,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(AppSvgs.search),
                                  ),
                                ),
                              ),
                            ),
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
                              padding: EdgeInsets.only(right: 50),
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
                  SizedBox(height: height * 0.03),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: height * 0.83,
                      width: double.infinity,
                      child: Consumer<ScreenTransitionProvider>(
                          builder: (context, providerIndex, child) {
                        return providerIndex.getIndex == 0
                            ? const ProgressManagementScreen()
                            : providerIndex.getIndex == 1
                                ? UserManagementScreen()
                                : providerIndex.getIndex == 2
                                    ? CommunityManagementScreen()
                                    : providerIndex.getIndex == 3
                                        ? GuestManagementScreen()
                                        : providerIndex.getIndex == 4
                                            ? BillingManagementScreen()
                                            : const SettingScreen();
                      }),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
