import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/model/model.dart';
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
  List<UserModel> userList = <UserModel>[];
  List<UserModel> filterList = <UserModel>[];

  void getUserData() async {
    final fireStore =
        await FirebaseFirestore.instance.collection('user_data').get();
    userList.addAll(
        fireStore.docs.map((doc) => UserModel.fromMap(doc.data(), doc.id)));
    setState(() {});
  }

  @override
  void initState() {
    searchController = TextEditingController();
    getUserData();
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
    if (width < 900) {
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
                  Container(
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
                          child: Text(
                            'Admin Panel',
                            style: TextStyle(
                              color: Color(0xFF424D57),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: SizedBox(
                                width: width * 0.17,
                                height: height * 0.07,
                                child: CustomTextField(
                                  hintText: 'Search here',
                                  controller: searchController,
                                  onChanged: (query) {
                                    if (query.isNotEmpty) {
                                      filterList = userList.where((user) {
                                        return user.name!
                                            .toLowerCase()
                                            .contains(query.toLowerCase());
                                      }).toList();
                                    } else {
                                      filterList.clear();
                                      setState(() {});
                                    }
                                  },
                                  fillColor: AppColor.white,
                                  borderColor: const Color(0xE5D1D9E6),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(AppSvgs.search),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0x190174BE),
                                    borderRadius: BorderRadius.circular(100)),
                                height: height * 0.07,
                                width: 40,
                                child: const Center(
                                  child: Text(
                                    'SA',
                                    style: TextStyle(
                                      color: Color(0xFF0174BE),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 50),
                              child: Text(
                                'Shakeel Awan',
                                style: TextStyle(
                                  color: Color(0xFF0C356A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
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
                                ? const UserManagementScreen()
                                : providerIndex.getIndex == 2
                                    ? CommunityManagementScreen()
                                    : providerIndex.getIndex == 3
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
