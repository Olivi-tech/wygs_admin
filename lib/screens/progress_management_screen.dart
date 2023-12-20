import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProgressManagementScreen extends StatelessWidget {
  ProgressManagementScreen({super.key, Key? ey});

  Stream<List<ProgressModel>> progressModelStream =
      ScreensServices.fetchProgressManagement();
  late ProgressCheckProvider progressCheckProvider;

  @override
  Widget build(BuildContext context) {
    progressCheckProvider =
        Provider.of<ProgressCheckProvider>(context, listen: false);
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
            return Column(
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
                  child: CustomText(
                    text: 'User’s Progress Management',
                    color: AppColor.blackish,
                    size: AppSize.xmeddium,
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
                          columnSpacing:
                              MediaQuery.of(context).size.width * .067,
                          columns: [
                            DataColumn(
                              label: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      progressCheckProvider
                                          .selectAll(progressData);
                                    },
                                    child: Consumer<ProgressCheckProvider>(
                                      builder: (context, value, child) {
                                        return Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                            child: value.isAllSeleted
                                                ? const Icon(
                                                    Icons.check,
                                                    size: 14,
                                                    color: AppColor.blue,
                                                  )
                                                : const SizedBox());
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const CustomText(
                                    text: 'Name',
                                    color: AppColor.indigo,
                                    size: AppSize.small,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            const DataColumn(
                              label: CustomText(
                                text: 'Email ID',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const DataColumn(
                              label: Flexible(
                                child: CustomText(
                                  text: 'Joining Date',
                                  color: AppColor.indigo,
                                  size: AppSize.small,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: CustomText(
                                text: 'Last Login',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const DataColumn(
                              label: CustomText(
                                text: 'Progress',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const DataColumn(
                              label: CustomText(
                                text: 'Status',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
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
                              cells: [
                                DataCell(
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          progressCheckProvider
                                              .toggleChecked(index);
                                        },
                                        child: Consumer<ProgressCheckProvider>(
                                          builder: (context, provider, child) =>
                                              Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                            child: provider.isSelected(index)
                                                ? const Icon(
                                                    Icons.check,
                                                    size: 14,
                                                    color: AppColor.blue,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CustomContainer(
                                        decoration: BoxDecoration(
                                          color: getNameColor(model.name ?? ''),
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
                                        child: CustomText(
                                          text: "${model.name}",
                                          color:
                                              AppColor.indigo.withOpacity(0.9),
                                          size: AppSize.xsmall,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: "${model.email}",
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: '${model.joiningDate}',
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomText(
                                    text: '${model.lastLogin}',
                                    color: AppColor.indigo.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DataCell(
                                  CustomContainer(
                                    decoration: BoxDecoration(
                                      color: AppColor.skyBlue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 23,
                                    width: 50,
                                    child: Center(
                                      child: CustomText(
                                        text: "${model.progress}",
                                        color: AppColor.indigo.withOpacity(0.9),
                                        size: AppSize.xsmall,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  CustomContainer(
                                    decoration: BoxDecoration(
                                      color: getStatusColor("${model.status}"),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 23,
                                    width: 77,
                                    child: Center(
                                      child: CustomText(
                                        text: "${model.status}",
                                        color: AppColor.white,
                                        size: AppSize.xsmall,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text('');
          }
        });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColor.green;
      case 'In Progress':
        return AppColor.blue;
      case 'Paused':
        return AppColor.red;
      default:
        return AppColor.indigo.withOpacity(0.9);
    }
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
    return CustomContainer(
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
            child: CustomContainer(
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
              child: CustomText(
                text: value,
                color: AppColor.midnightBlue,
                size: AppSize.large,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 10),
              child: FittedBox(
                child: CustomText(
                  text: label,
                  size: AppSize.xmeddium,
                  color: AppColor.midnightBlue,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
