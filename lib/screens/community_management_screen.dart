import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/components/components.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/community_model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CommunityManagementScreen extends StatelessWidget {
  CommunityManagementScreen({super.key});

  Stream<List<CommunityModel>> communityStream =
      FirestoreServices.fetchUserCollectionData<CommunityModel>(
          'community_data', (data, id) => CommunityModel.fromMap(data, id));
  late CommunityCheckProvider communityCheckProvider;
  TextEditingController controller = TextEditingController();
  ValueNotifier<String> searchNotifier = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    communityCheckProvider =
        Provider.of<CommunityCheckProvider>(context, listen: false);
    return Column(
      children: [
        CustomAppBar(
            controller: controller,
            setSearchValue: (searchQuery) {
              searchNotifier.value = searchQuery;
            }),
        SizedBox(height: height * 0.03),
        Expanded(
          child: StreamBuilder(
            stream: communityStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: ValueListenableBuilder(
                    valueListenable: searchNotifier,
                    builder: (context, query, child) {
                      List<CommunityModel> communityData = query.isEmpty
                          ? snapshot.data!
                          : snapshot.data!
                              .where(
                                (data) => data.postBy!
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 25),
                            child: Text(
                              'Community’ Post Management',
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: MaterialStateColor.resolveWith(
                                          (states) =>
                                              Provider.of<CommunityCheckProvider>(
                                                                  context)
                                                              .selectedIndices
                                                              .length ==
                                                          communityData
                                                              .length &&
                                                      communityData.isNotEmpty
                                                  ? AppColor.paleBlue
                                                  : AppColor.white),
                                    ),
                                    columnSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.054,
                                    columns: [
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              communityCheckProvider
                                                  .selectAll(communityData);
                                            },
                                            child: Consumer<
                                                CommunityCheckProvider>(
                                              builder: (context, value, child) {
                                                return Container(
                                                    height: 18,
                                                    width: 18,
                                                    decoration: BoxDecoration(
                                                        color: value.selectedIndices.length ==
                                                                    communityData
                                                                        .length &&
                                                                communityData
                                                                    .isNotEmpty
                                                            ? AppColor.green
                                                            : AppColor.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        border: value.selectedIndices
                                                                        .length ==
                                                                    communityData
                                                                        .length &&
                                                                communityData
                                                                    .isNotEmpty
                                                            ? Border.all(
                                                                color: AppColor.green)
                                                            : Border.all(color: Colors.black.withOpacity(0.7))),
                                                    child: value.selectedIndices.length == communityData.length && communityData.isNotEmpty
                                                        ? const Icon(
                                                            Icons.check,
                                                            size: 14,
                                                            color:
                                                                AppColor.white,
                                                          )
                                                        : const SizedBox());
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const CustomTextDataColumn(
                                              text: 'Image')
                                        ],
                                      )),
                                      const DataColumn(
                                        label: Expanded(
                                          child: CustomTextDataColumn(
                                              text: 'Posted by'),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Expanded(
                                          child: CustomTextDataColumn(
                                              text: 'Description'),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Expanded(
                                          child: CustomTextDataColumn(
                                              text: 'Posting Date'),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Expanded(
                                          child: CustomTextDataColumn(
                                              text: 'No of Likes'),
                                        ),
                                      ),
                                      const DataColumn(
                                        label: Expanded(
                                          child: CustomTextDataColumn(
                                              text: 'No of Comments'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Row(
                                            children: [
                                              const CustomTextDataColumn(
                                                  text: 'Status'),
                                              SizedBox(width: width * 0.03),
                                              Consumer<CommunityCheckProvider>(
                                                builder:
                                                    (context, value, child) {
                                                  return value.selectedIndices
                                                              .length ==
                                                          communityData.length && communityData.isNotEmpty
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
                                                              FirestoreServices
                                                                  .deleteUserCollection(
                                                                      'community_data');
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3.0),
                                                              child: SvgPicture
                                                                  .asset(AppSvgs
                                                                      .delete),
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
                                    rows: communityData.asMap().entries.map(
                                        (MapEntry<int, CommunityModel> entry) {
                                      final int index = entry.key;
                                      final CommunityModel model = entry.value;
                                      return DataRow(
                                        color: MaterialStateColor.resolveWith(
                                          (states) {
                                            return Provider.of<
                                                            CommunityCheckProvider>(
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
                                                  child: Consumer<
                                                      CommunityCheckProvider>(
                                                    builder: (context, provider,
                                                            child) =>
                                                        Container(
                                                      height: 18,
                                                      width: 18,
                                                      decoration: BoxDecoration(
                                                        color: provider
                                                                .isSelected(
                                                                    index)
                                                            ? AppColor.green
                                                            : AppColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: provider
                                                                .isSelected(
                                                                    index)
                                                            ? Border.all(
                                                                color: AppColor
                                                                    .green)
                                                            : Border.all(
                                                                color: AppColor
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7)),
                                                      ),
                                                      child: provider
                                                              .isSelected(index)
                                                          ? const Icon(
                                                              Icons.check,
                                                              size: 14,
                                                              color: AppColor
                                                                  .white,
                                                            )
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Image.network(
                                                      model.userProfileUrl!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          DataCell(
                                            CustomTextDataRow(
                                                text: model.postBy ?? ''),
                                          ),
                                          DataCell(
                                            CustomTextDataRow(
                                                text: model.postMessage ?? '',
                                                maxLine: 3),
                                          ),
                                          DataCell(
                                            CustomTextDataRow(
                                                text: model.postDate ?? ''),
                                          ),
                                          DataCell(
                                            CustomTextDataRow(
                                                text: model.likes!.toString()),
                                          ),
                                          DataCell(
                                            CustomTextDataRow(
                                                text:
                                                    model.comments!.toString()),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColorUtlis
                                                        .getStatusColor(
                                                            model.postBy!),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  height: 23,
                                                  width: 77,
                                                  child: Center(
                                                      child: CustomTextDataRow(
                                                          text: model.postBy!)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Consumer<
                                                      CommunityCheckProvider>(
                                                    builder: (context, value,
                                                        child) {
                                                      return value.selectedIndices
                                                                  .length ==
                                                              communityData
                                                                  .length
                                                          ? const SizedBox()
                                                          : GestureDetector(
                                                              onTap: () {
                                                                communityCheckProvider
                                                                    .toggleChecked(
                                                                        index);
                                                              },
                                                              child: value
                                                                      .isSelected(
                                                                          index)
                                                                  ? Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              25,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.white,
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {},
                                                                            child: const Padding(
                                                                                padding: EdgeInsets.all(3.0),
                                                                                child: Icon(
                                                                                  Icons.edit,
                                                                                  color: AppColor.blue,
                                                                                  size: 22,
                                                                                )),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 4),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            decoration:
                                                                                BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                deleteDocumentDialog(context, model.postId!, 'community_data');
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(3.0),
                                                                                child: SvgPicture.asset(AppSvgs.delete),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
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
                      );
                    },
                  ),
                );
              } else {
                return const Text('');
              }
            },
          ),
        ),
      ],
    );
  }
}
