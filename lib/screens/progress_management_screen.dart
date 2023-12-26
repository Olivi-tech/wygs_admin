import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/firestore_services.dart';
import 'package:guitar_songs/model/progress_model.dart';
import 'package:guitar_songs/providers/progress_screen_provider.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/custom_text_data_column.dart';
import 'package:guitar_songs/widgets/custom_text_data_row.dart';
import 'package:provider/provider.dart';

class ProgressManagementScreen extends StatefulWidget {
  const ProgressManagementScreen({super.key});

  @override
  State<ProgressManagementScreen> createState() =>
      _ProgressManagementScreenState();
}

class _ProgressManagementScreenState extends State<ProgressManagementScreen> {
  Stream<List<ProgressModel>> progressModelStream =
      FirestoreServices.fetchCollectionData(
          'progressManagement', (data) => ProgressModel.fromMap(data));
  late ProgressCheckProvider progressCheckProvider;
  late ValueNotifier<bool> isExpanded;
  late TextEditingController feedbackController;

  @override
  void initState() {
    progressCheckProvider =
        Provider.of<ProgressCheckProvider>(context, listen: false);
    feedbackController = TextEditingController();
    isExpanded = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return StreamBuilder(
      stream: progressModelStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CupertinoActivityIndicator(
            color: AppColor.blue,
          ));
        } else if (snapshot.hasData) {
          List<ProgressModel> progressData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: MaterialStateColor.resolveWith((states) =>
                              Provider.of<ProgressCheckProvider>(context)
                                          .selectedIndices
                                          .length ==
                                      progressData.length
                                  ? AppColor.paleBlue
                                  : AppColor.white),
                        ),
                        columnSpacing: MediaQuery.of(context).size.width * 0.04,
                        columns: [
                          DataColumn(
                            label: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    progressCheckProvider
                                        .selectAll(progressData);
                                  },
                                  child: Consumer<ProgressCheckProvider>(
                                    builder: (context, provider, child) {
                                      return Container(
                                          height: 18,
                                          width: 18,
                                          decoration: BoxDecoration(
                                            color: provider.selectedIndices
                                                        .length ==
                                                    progressData.length
                                                ? AppColor.green
                                                : AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: provider.selectedIndices
                                                        .length ==
                                                    progressData.length
                                                ? Border.all(
                                                    color: AppColor.green
                                                        .withOpacity(0.7))
                                                : Border.all(
                                                    color: AppColor.black
                                                        .withOpacity(0.7)),
                                          ),
                                          child:
                                              provider.selectedIndices.length ==
                                                      progressData.length
                                                  ? const Icon(
                                                      Icons.check,
                                                      size: 14,
                                                      color: AppColor.white,
                                                    )
                                                  : null);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const CustomTextDataColumn(text: 'Name'),
                              ],
                            ),
                          ),
                          const DataColumn(
                            label: CustomTextDataColumn(text: 'Lead Guitar'),
                          ),
                          const DataColumn(
                            label: Flexible(
                              child:
                                  CustomTextDataColumn(text: 'Rhythm Guitar'),
                            ),
                          ),
                          const DataColumn(
                            label: CustomTextDataColumn(text: 'Bass Guitar'),
                          ),
                          const DataColumn(
                            label: CustomTextDataColumn(text: 'Drums'),
                          ),
                          const DataColumn(
                            label: CustomTextDataColumn(text: 'Vocal/Mic'),
                          ),
                          const DataColumn(
                            label: CustomTextDataColumn(text: 'Keyboard'),
                          ),
                          DataColumn(
                            label: Row(
                              children: [
                                const CustomTextDataColumn(text: 'Piano'),
                                SizedBox(width: width * 0.015),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Consumer<ProgressCheckProvider>(
                                    builder: (context, value, child) {
                                      return value.selectedIndices.length ==
                                              progressData.length
                                          ? Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: AppColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  feedbackDialog(context,
                                                      feedbackController);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: SvgPicture.asset(
                                                      AppSvgs.delete),
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
                        rows: progressData
                            .asMap()
                            .entries
                            .map((MapEntry<int, ProgressModel> entry) {
                          final int index = entry.key;
                          final ProgressModel model = entry.value;
                          return DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) {
                                return Provider.of<ProgressCheckProvider>(
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
                                        progressCheckProvider.toogle(index);
                                      },
                                      child: Consumer<ProgressCheckProvider>(
                                        builder: (context, provider, child) {
                                          return Container(
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
                                                  : null);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: getNameColor('${model.name}'),
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                      height: 25,
                                      width: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child:
                                            SvgPicture.asset(AppSvgs.userBold),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: CustomTextDataRow(
                                          text: '${model.name}'),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                InkWell(
                                    onTap: () {
                                      // isExpanded.value = isExpanded.value;
                                    },
                                    child: isExpanded.value
                                        ? SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Column(
                                              children: [
                                                CustomTextDataRow(
                                                    text:
                                                        '${model.leadGuitar}'),
                                                CustomTextDataRow(
                                                    text:
                                                        '${model.leadGuitar}'),
                                                CustomTextDataRow(
                                                    text:
                                                        '${model.leadGuitar}'),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.skyBlue,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            height: 23,
                                            width: 50,
                                            child: Center(
                                              child: CustomTextDataRow(
                                                  text: '${model.leadGuitar}'),
                                            ),
                                          )),
                              ),
                              DataCell(
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.skyBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 23,
                                  width: 50,
                                  child: Center(
                                    child: CustomTextDataRow(
                                        text: '${model.rhythmGuitar}'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.skyBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 23,
                                  width: 50,
                                  child: Center(
                                    child: CustomTextDataRow(
                                        text: '${model.bassGuitar}'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.skyBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 23,
                                  width: 50,
                                  child: Center(
                                    child: CustomTextDataRow(
                                        text: '${model.drums}'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.skyBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 23,
                                  width: 50,
                                  child: Center(
                                    child:
                                        CustomTextDataRow(text: '${model.mic}'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.skyBlue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 23,
                                  width: 50,
                                  child: Center(
                                    child: CustomTextDataRow(
                                        text: '${model.keyboard}'),
                                  ),
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.skyBlue,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 23,
                                      width: 50,
                                      child: Center(
                                        child: CustomTextDataRow(
                                            text: '${model.piano}'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Consumer<ProgressCheckProvider>(
                                        builder: (context, value, child) {
                                          return value.selectedIndices.length ==
                                                  progressData.length
                                              ? const SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    progressCheckProvider
                                                        .toogle(index);
                                                  },
                                                  child: value.isSelected(index)
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
                                                                      .all(3.0),
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
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Color getNameColor(String name) {
    String firstLetter = name.isNotEmpty ? name[0].trim() : "";
    switch (firstLetter) {
      case "A":
        return AppColor.lightBlue;
      case "B":
        return AppColor.orange.withOpacity(0.7);
      case "C":
        return AppColor.seaGreen;
      case "D":
        return AppColor.blue;
      case "E":
        return AppColor.lightBlue;
      case "F":
        return AppColor.orange.withOpacity(0.7);
      case "G":
        return AppColor.seaGreen;
      case "H":
        return AppColor.blue;
      case "I":
        return AppColor.lightBlue;
      case "P":
        return AppColor.orange.withOpacity(0.7);
      case "J":
        return AppColor.seaGreen;
      case "R":
        return AppColor.blue;
      case "N":
        return AppColor.lightBlue;
      case "M":
        return AppColor.orange.withOpacity(0.7);
      case "K":
        return AppColor.seaGreen;
      case "O":
        return AppColor.blue;
      default:
        return AppColor.indigo.withOpacity(0.9);
    }
  }
}
