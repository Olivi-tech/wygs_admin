import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/community_model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/widgets/custom_dialouge.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CommunityManagementScreen extends StatelessWidget {
  CommunityManagementScreen({super.key});

  Stream<List<CommunityModel>> communityStream =
      FirestoreServices.fetchCommunityManagement();
  late CommunityCheckProvider communityCheckProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    communityCheckProvider =
        Provider.of<CommunityCheckProvider>(context, listen: false);
    return StreamBuilder(
      stream: communityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColor.blue),
          );
        } else if (snapshot.hasData) {
          List<CommunityModel> communityData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 25),
                  child: CustomText(
                    text: 'Community’ Post Management',
                    color: AppColor.blackish,
                    size: AppSize.large,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 30),
                  child: CustomContainer(
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
                                Provider.of<CommunityCheckProvider>(context)
                                            .selectedIndices
                                            .length ==
                                        communityData.length
                                    ? AppColor.paleBlue
                                    : AppColor.white),
                          ),
                          columnSpacing:
                              MediaQuery.of(context).size.width * .05,
                          columns: [
                            DataColumn(
                                label: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    communityCheckProvider
                                        .selectAll(communityData);
                                  },
                                  child: Consumer<CommunityCheckProvider>(
                                    builder: (context, value, child) {
                                      return Container(
                                          height: 18,
                                          width: 18,
                                          decoration: BoxDecoration(
                                              color: value.selectedIndices
                                                          .length ==
                                                      communityData.length
                                                  ? AppColor.green
                                                  : AppColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: value.selectedIndices
                                                          .length ==
                                                      communityData.length
                                                  ? Border.all(
                                                      color: AppColor.green)
                                                  : Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.7))),
                                          child: value.selectedIndices.length ==
                                                  communityData.length
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
                                const CustomText(
                                  text: 'Image',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )),
                            const DataColumn(
                              label: Expanded(
                                child: CustomText(
                                  text: 'Posted by',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Expanded(
                                child: CustomText(
                                  text: 'Description',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Expanded(
                                child: CustomText(
                                  text: 'Posting Date',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Expanded(
                                child: CustomText(
                                  text: 'No of Likes',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Expanded(
                                child: CustomText(
                                  text: 'No of Comments',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Row(
                                  children: [
                                    const CustomText(
                                      text: 'Status',
                                      color: AppColor.indigo,
                                      size: AppSize.small,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Consumer<CommunityCheckProvider>(
                                      builder: (context, value, child) {
                                        return value.selectedIndices.length ==
                                                communityData.length
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
                                                    customDialouge(context);
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
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                          rows: communityData
                              .asMap()
                              .entries
                              .map((MapEntry<int, CommunityModel> entry) {
                            final int index = entry.key;
                            final CommunityModel model = entry.value;
                            return DataRow(
                              color: MaterialStateColor.resolveWith(
                                (states) {
                                  return Provider.of<CommunityCheckProvider>(
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
                                          communityCheckProvider
                                              .toggleChecked(index);
                                        },
                                        child: Consumer<CommunityCheckProvider>(
                                          builder: (context, provider, child) =>
                                              Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: provider.isSelected(index)
                                                  ? AppColor.green
                                                  : AppColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: provider.isSelected(index)
                                                  ? Border.all(
                                                      color: AppColor.green)
                                                  : Border.all(
                                                      color: AppColor.black
                                                          .withOpacity(0.7)),
                                            ),
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
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(AppImages.community),
                                      )
                                      // SizedBox(
                                      //   height: 20,
                                      //   width: 20,
                                      //   child: Image.network(model.image!),
                                      // )
                                    ],
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: '${model.postBy}',
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    maxLine: 3,
                                    softWrap: true,
                                    text: '${model.description}',
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: '${model.date}',
                                    color: const Color.fromARGB(255, 72, 50, 67)
                                        .withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: model.likes!,
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: model.comments!,
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      CustomContainer(
                                        decoration: BoxDecoration(
                                          color: getColorStatus(model.status!),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 23,
                                        width: 77,
                                        child: Center(
                                          child: CustomText(
                                            text: model.status!,
                                            color: AppColor.white,
                                            size: AppSize.xsmall,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Consumer<CommunityCheckProvider>(
                                          builder: (context, value, child) {
                                            return value.selectedIndices
                                                        .length ==
                                                    communityData.length
                                                ? const SizedBox()
                                                : GestureDetector(
                                                    onTap: () {
                                                      communityCheckProvider
                                                          .toggleChecked(index);
                                                    },
                                                    child:
                                                        value.isSelected(index)
                                                            ? Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    customDialouge(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Padding(
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
                )
              ],
            ),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}

Color getColorStatus(String status) {
  switch (status) {
    case 'Active':
      return AppColor.green;
    case 'In Progress':
      return AppColor.blue;
    case 'Paused':
      return AppColor.red;
    default:
      return AppColor.indigo.withOpacity(0.9);
  }
}
