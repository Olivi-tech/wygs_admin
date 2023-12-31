import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/components/components.dart';

import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/firestore_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/progress_screen_provider.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProgressManagementScreen extends StatefulWidget {
  const ProgressManagementScreen({super.key});

  @override
  State<ProgressManagementScreen> createState() =>
      _ProgressManagementScreenState();
}

class _ProgressManagementScreenState extends State<ProgressManagementScreen> {
  late Stream<List<ProgressModel>> progressModelStream;
  late ProgressCheckProvider progressCheckProvider;
  late TextEditingController controller;
  late ValueNotifier<String> searchNotifier;

  @override
  void initState() {
    searchNotifier = ValueNotifier('');
    controller = TextEditingController();
    progressModelStream =
        FirestoreServices.fetchUserCollectionData<ProgressModel>(
            'users_progress', (data, id) => ProgressModel.fromMap(data, id));
    progressCheckProvider =
        Provider.of<ProgressCheckProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Column(
      children: [
        CustomAppBar(
          controller: controller,
          setSearchValue: (searchQuery) {
            searchNotifier.value = searchQuery;
          },
        ),
        SizedBox(height: height * 0.03),
        Expanded(
          child: StreamBuilder(
            stream: progressModelStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CupertinoActivityIndicator(
                  color: AppColor.blue,
                ));
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: ValueListenableBuilder(
                    valueListenable: searchNotifier,
                    builder: (context, query, child) {
                      List<ProgressModel> progressData = query.isEmpty
                          ? snapshot.data!
                          : snapshot.data!
                              .where((data) => data.userName!
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Text(
                              'Progress Management',
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
                                            Provider.of<ProgressCheckProvider>(
                                                                context)
                                                            .selectedIndices
                                                            .length ==
                                                        progressData.length 
                                                ? AppColor.paleBlue
                                                : AppColor.white),
                                  ),
                                  columnSpacing:
                                      MediaQuery.of(context).size.width *
                                          0.0265,
                                  columns: [
                                    DataColumn(
                                      label: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              progressCheckProvider
                                                  .selectAll(progressData);
                                            },
                                            child:
                                                Consumer<ProgressCheckProvider>(
                                              builder:
                                                  (context, provider, child) {
                                                return Container(
                                                    height: 18,
                                                    width: 18,
                                                    decoration: BoxDecoration(
                                                      color: provider.selectedIndices
                                                                      .length ==
                                                                  progressData
                                                                      .length 
                                                          ? AppColor.green
                                                          : AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: provider.selectedIndices
                                                                      .length ==
                                                                  progressData
                                                                      .length 
                                                          ? Border.all(
                                                              color: AppColor
                                                                  .green
                                                                  .withOpacity(
                                                                      0.7))
                                                          : Border.all(
                                                              color: AppColor
                                                                  .black
                                                                  .withOpacity(
                                                                      0.7)),
                                                    ),
                                                    child: provider.selectedIndices
                                                                    .length ==
                                                                progressData
                                                                    .length 
                                                        ? const Icon(
                                                            Icons.check,
                                                            size: 14,
                                                            color:
                                                                AppColor.white,
                                                          )
                                                        : null);
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const CustomTextDataColumn(
                                              text: 'Name'),
                                        ],
                                      ),
                                    ),
                                    const DataColumn(
                                      label: CustomTextDataColumn(
                                          text: 'Lead Guitar'),
                                    ),
                                    const DataColumn(
                                      label: Flexible(
                                        child: CustomTextDataColumn(
                                            text: 'Rhythm Guitar'),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: CustomTextDataColumn(
                                          text: 'Bass Guitar'),
                                    ),
                                    const DataColumn(
                                      label:
                                          CustomTextDataColumn(text: 'Drums'),
                                    ),
                                    const DataColumn(
                                      label: CustomTextDataColumn(
                                          text: 'Vocal/Mic'),
                                    ),
                                    const DataColumn(
                                      label: CustomTextDataColumn(
                                          text: 'Keyboard'),
                                    ),
                                    DataColumn(
                                      label: Row(
                                        children: [
                                          const CustomTextDataColumn(
                                              text: 'Piano'),
                                          SizedBox(width: width * 0.015),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child:
                                                Consumer<ProgressCheckProvider>(
                                              builder: (context, value, child) {
                                                return value.selectedIndices
                                                                .length ==
                                                            progressData
                                                                .length 
                                                    ? Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppColor.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            deleteDialog(
                                                                context,
                                                                'users_progress');
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
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                  rows: progressData.asMap().entries.map(
                                      (MapEntry<int, ProgressModel> entry) {
                                    final int index = entry.key;
                                    final ProgressModel model = entry.value;
                                    String completedDay =
                                        '${model.completedDays}';
                                    int numericValue =
                                        extractDayValue(completedDay);
                                    return DataRow(
                                      color: MaterialStateColor.resolveWith(
                                        (states) {
                                          return Provider.of<
                                                          ProgressCheckProvider>(
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
                                                  progressCheckProvider
                                                      .toogle(index);
                                                },
                                                child: Consumer<
                                                    ProgressCheckProvider>(
                                                  builder: (context, provider,
                                                      child) {
                                                    return Container(
                                                        height: 18,
                                                        width: 18,
                                                        decoration:
                                                            BoxDecoration(
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
                                                        child:
                                                            provider.isSelected(
                                                                    index)
                                                                ? const Icon(
                                                                    Icons.check,
                                                                    size: 14,
                                                                    color: AppColor
                                                                        .white,
                                                                  )
                                                                : null);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColorUtlis
                                                      .getNameColor(
                                                          '${model.userName}'),
                                                  borderRadius:
                                                      BorderRadius.circular(36),
                                                ),
                                                height: 25,
                                                width: 25,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: SvgPicture.asset(
                                                      AppSvgs.userBold),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Flexible(
                                                child: CustomTextDataRow(
                                                  text: '${model.userName}',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          InkWell(
                                              onTap: () =>
                                                  questionDialogLeadGuitar(
                                                      context,
                                                      controller,
                                                      model.userId!),
                                              child: buildContainer(
                                                  '${numericValue >= 1 || numericValue < 7 ? 'Completed' : 'In Progress'} ')),
                                        ),
                                        DataCell(
                                          InkWell(
                                              onTap: () {
                                                numericValue >= 2
                                                    ? questionDialogRhythmGuitar(
                                                        context,
                                                        controller,
                                                        model.userId!)
                                                    : toastMessage(
                                                        'The user has not submitted yet.');
                                              },
                                              child: buildContainer(
                                                  '${numericValue >= 2 ? 'Completed' : 'In Progress'} ')),
                                        ),
                                        DataCell(
                                          InkWell(
                                              onTap: () => numericValue >= 3
                                                  ? questionDialogBassGuitar(
                                                      context,
                                                      controller,
                                                      model.userId!)
                                                  : toastMessage(
                                                      'The user has not submitted yet.'),
                                              child: buildContainer(
                                                  '${numericValue >= 3 ? 'Completed' : 'In Progress'} ')),
                                        ),
                                        DataCell(
                                          InkWell(
                                              onTap: () => numericValue >= 4
                                                  ? questionDialogDrums(context,
                                                      controller, model.userId!)
                                                  : toastMessage(
                                                      'The user has not submitted yet.'),
                                              child: buildContainer(
                                                  '${numericValue >= 4 ? 'Completed' : 'In Progress'} ')),
                                        ),
                                        DataCell(
                                          InkWell(
                                              onTap: () => numericValue >= 5
                                                  ? questionDialogVocal(context,
                                                      controller, model.userId!)
                                                  : toastMessage(
                                                      'The user has not submitted yet.'),
                                              child: buildContainer(
                                                  '${numericValue >= 5 ? 'Completed' : 'In Progress'} ')),
                                        ),
                                        DataCell(
                                          InkWell(
                                              onTap: () => numericValue >= 6
                                                  ? questionDialogKeyboard(
                                                      context,
                                                      controller,
                                                      model.userId!)
                                                  : toastMessage(
                                                      'The user has not submitted yet.'),
                                              child: buildContainer(
                                                  '${numericValue >= 6 ? 'Completed' : 'In Progress'} ')),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () => numericValue >= 7
                                                      ? questionDialogPiano(
                                                          context,
                                                          controller,
                                                          model.userId!)
                                                      : toastMessage(
                                                          'The user has not submitted yet'),
                                                  child: buildContainer(
                                                      '${numericValue >= 7 ? 'Completed' : 'In Progress'} ')),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Consumer<
                                                    ProgressCheckProvider>(
                                                  builder:
                                                      (context, value, child) {
                                                    return value.selectedIndices
                                                                .length ==
                                                            progressData.length
                                                        ? const SizedBox()
                                                        : GestureDetector(
                                                            onTap: () {
                                                              progressCheckProvider
                                                                  .toogle(
                                                                      index);
                                                            },
                                                            child: value
                                                                    .isSelected(
                                                                        index)
                                                                ? Container(
                                                                    height: 25,
                                                                    width: 25,
                                                                    decoration: BoxDecoration(
                                                                        color: AppColor
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        customDialog(
                                                                            context:
                                                                                context,
                                                                            userId:
                                                                                model.userId!);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                        child: SvgPicture.asset(
                                                                            AppSvgs.delete),
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
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.skyBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 23,
      width: 75,
      child: Center(
        child: CustomTextDataRow(text: text),
      ),
    );
  }
}
