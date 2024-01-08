import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/screens/screens.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  bool isDrawerVisible = true;

  List<UserModel> userList = <UserModel>[];

  List<UserModel> filterList = <UserModel>[];

  void getUserData() async {
    final fireStore =
        await FirebaseFirestore.instance.collection('user_data').get();
    userList.addAll(
        fireStore.docs.map((doc) => UserModel.fromMap(doc.data(), doc.id)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}
