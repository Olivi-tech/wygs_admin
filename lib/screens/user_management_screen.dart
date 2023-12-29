import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserManagementScreen extends StatelessWidget {
  UserManagementScreen({super.key, Key? ey});

  Stream<List<UserModel>> userModelStream =
      FirestoreServices.fetchCollectionData(
          'userManagement', (data) => UserModel.fromMap(data));
  late UserCheckProvider userCheckProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width = size.width;
    userCheckProvider = Provider.of<UserCheckProvider>(context, listen: false);
    return StreamBuilder(
        stream: userModelStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: AppColor.blue,
            ));
          } else if (snapshot.hasData) {
            List<UserModel> userData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: CustomContainerWithIconAndText(
                              icon: AppSvgs.userBold,
                              value: '37,403',
                              label: 'Total Users',
                              color: Color(0xFF605BFF),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: CustomContainerWithIconAndText(
                              icon: AppSvgs.userBold,
                              value: '4357',
                              label: 'Active Users',
                              color: AppColor.orange,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: CustomContainerWithIconAndText(
                              icon: AppSvgs.document,
                              value: '503',
                              label: 'Total Community Post',
                              color: AppColor.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 25),
                    child: Text(
                      'User’s Management',
                      style: TextStyle(
                        color: AppColor.blackish,
                        fontSize: AppSize.large,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 30),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.jetBlack),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: MaterialStateColor.resolveWith((states) =>
                                  Provider.of<UserCheckProvider>(context)
                                              .selectedIndices
                                              .length ==
                                          userData.length
                                      ? AppColor.paleBlue
                                      : AppColor.white),
                            ),
                            columnSpacing:
                                MediaQuery.of(context).size.width * 0.115,
                            columns: [
                              DataColumn(
                                label: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        userCheckProvider.selectAll(userData);
                                      },
                                      child: Consumer<UserCheckProvider>(
                                        builder: (context, value, child) {
                                          return Container(
                                              height: 18,
                                              width: 18,
                                              decoration: BoxDecoration(
                                                  color: value.selectedIndices
                                                              .length ==
                                                          userData.length
                                                      ? AppColor.green
                                                      : AppColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: value.selectedIndices
                                                              .length ==
                                                          userData.length
                                                      ? Border.all(
                                                          color: AppColor.green
                                                              .withOpacity(0.7))
                                                      : Border.all(
                                                          color: AppColor.black
                                                              .withOpacity(0.7))),
                                              child: value.selectedIndices.length == userData.length
                                                  ? const Icon(
                                                      Icons.check,
                                                      size: 14,
                                                      color: AppColor.white,
                                                    )
                                                  : const SizedBox());
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const CustomTextDataColumn(text: 'Name'),
                                  ],
                                ),
                              ),
                              const DataColumn(
                                label: CustomTextDataColumn(text: 'Email ID'),
                              ),
                              const DataColumn(
                                label: Flexible(
                                  child: CustomTextDataColumn(
                                      text: 'Joining Date'),
                                ),
                              ),
                              const DataColumn(
                                label: CustomTextDataColumn(text: 'Last Login'),
                              ),
                              DataColumn(
                                label: Row(
                                  children: [
                                    const CustomTextDataColumn(text: 'Status'),
                                    SizedBox(width: width * 0.04),
                                    Consumer<UserCheckProvider>(
                                      builder: (context, value, child) {
                                        return value.selectedIndices.length ==
                                                userData.length
                                            ? Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    color: AppColor.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    customDialog(
                                                      context,
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: SvgPicture.asset(
                                                        AppSvgs.delete),
                                                  ),
                                                ))
                                            : const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            rows: userData
                                .asMap()
                                .entries
                                .map((MapEntry<int, UserModel> entry) {
                              final int index = entry.key;
                              final UserModel model = entry.value;

                              return DataRow(
                                color: MaterialStateColor.resolveWith(
                                  (states) {
                                    return Provider.of<UserCheckProvider>(
                                                context)
                                            .isSelected(index)
                                        ? AppColor.paleBlue
                                        : AppColor.white;
                                  },
                                ),
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            userCheckProvider
                                                .toggleChecked(index);
                                          },
                                          child: Consumer<UserCheckProvider>(
                                            builder:
                                                (context, provider, child) =>
                                                    Container(
                                              height: 18,
                                              width: 18,
                                              decoration: BoxDecoration(
                                                  color:
                                                      provider.isSelected(index)
                                                          ? AppColor.green
                                                          : AppColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: provider
                                                          .isSelected(index)
                                                      ? Border.all(
                                                          color: AppColor.green
                                                              .withOpacity(0.7))
                                                      : Border.all(
                                                          color: AppColor.black
                                                              .withOpacity(
                                                                  0.7))),
                                              child: provider.isSelected(index)
                                                  ? const Icon(
                                                      Icons.check,
                                                      size: 14,
                                                      color: AppColor.white,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColorUtlis.getNameColor(
                                                model.name ?? ''),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          height: 25,
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: SvgPicture.asset(
                                                AppSvgs.userBold),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          child: CustomTextDataRow(
                                            text: "${model.name}",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    CustomTextDataRow(text: "${model.email}"),
                                  ),
                                  DataCell(
                                    CustomTextDataRow(
                                        text: "${model.joiningDate}"),
                                  ),
                                  DataCell(
                                    CustomTextDataRow(
                                        text: "${model.lastLogin}"),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColorUtlis.getStatusColor(
                                                "${model.status}"),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          height: 23,
                                          width: 77,
                                          child: Center(
                                            child: CustomTextDataRow(
                                                text: "${model.status}"),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Consumer<UserCheckProvider>(
                                            builder: (context, value, child) {
                                              return value.selectedIndices
                                                          .length ==
                                                      userData.length
                                                  ? const SizedBox()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        userCheckProvider
                                                            .toggleChecked(
                                                                index);
                                                      },
                                                      child: value
                                                              .isSelected(index)
                                                          ? Container(
                                                              height: 25,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  customDialog(
                                                                    context,
                                                                  );
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          3.0),
                                                                  child: SvgPicture
                                                                      .asset(AppSvgs
                                                                          .delete),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList()),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('');
          }
        });
  }
}

class CustomContainerWithIconAndText extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final Color color;

  const CustomContainerWithIconAndText({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      height: height * 0.1,
      width: width * 0.27,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.jetBlack),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Container(
              height: height * 0.07,
              width: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.asset(icon),
              ),
            ),
          ),
          SizedBox(width: width * 0.01),
          Expanded(
            child: FittedBox(
              child: Text(
                value,
                style: const TextStyle(
                  color: AppColor.midnightBlue,
                  fontSize: AppSize.xlarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 10),
              child: FittedBox(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppSize.large,
                    color: AppColor.midnightBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
