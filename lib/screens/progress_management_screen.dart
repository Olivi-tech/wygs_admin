import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class ProgressManagementScreen extends StatelessWidget {
  const ProgressManagementScreen({super.key, Key? ey});

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'John Doe',
      'Pam Bessely',
      'Samantha Rodd',
      'George Belly',
      'John Doe',
      'Pam Bessely',
      'Samantha Rodd',
      'George Belly',
    ];

    List<String> progressRate = [
      '07/07',
      '06/07',
      '07/07',
      '07/07',
      '04/07',
      '07/07',
      '04/07',
      '07/07',
    ];

    List<String> status = [
      'Completed',
      'In Progress',
      'Completed',
      'In Progress',
      'Paused',
      'Completed',
      'In Progress',
      'In Progress',
    ];

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
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: CustomContainer(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: MediaQuery.of(context).size.width * .067,
                columns: [
                  DataColumn(
                    label: Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: AppColor.lightWhite,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColor.blackish.withOpacity(0.7)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const CustomText(
                          text: 'Name',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  const DataColumn(
                    label: CustomText(
                      text: 'Email ID',
                      color: AppColor.lightBlack,
                      size: AppSize.small,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: Flexible(
                      child: CustomText(
                        text: 'Joining Date',
                        color: AppColor.lightBlack,
                        size: AppSize.small,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: CustomText(
                      text: 'Last Login',
                      color: AppColor.lightBlack,
                      size: AppSize.small,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: CustomText(
                      text: 'Progress',
                      color: AppColor.lightBlack,
                      size: AppSize.small,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const DataColumn(
                    label: CustomText(
                      text: 'Status',
                      color: AppColor.lightBlack,
                      size: AppSize.small,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                rows: List.generate(
                  names.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: AppColor.lightWhite,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColor.blackish.withOpacity(0.7)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            CustomContainer(
                              decoration: BoxDecoration(
                                color: getNameColor(index),
                                borderRadius: BorderRadius.circular(36),
                              ),
                              height: 25,
                              width: 25,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SvgPicture.asset(AppSvgs.userBold),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: CustomText(
                                text: names[index],
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        CustomText(
                          text: 'username@email.com',
                          color: AppColor.lightBlack.withOpacity(0.9),
                          size: AppSize.xsmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DataCell(
                        CustomText(
                          text: '22/08/2023',
                          color: AppColor.lightBlack.withOpacity(0.9),
                          size: AppSize.xsmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DataCell(
                        CustomText(
                          text: '15/04/2023',
                          color: AppColor.lightBlack.withOpacity(0.9),
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
                              text: progressRate[index],
                              color: AppColor.lightBlack.withOpacity(0.9),
                              size: AppSize.xsmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        CustomContainer(
                          decoration: BoxDecoration(
                            color: getStatusColor(status[index]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 23,
                          width: 77,
                          child: Center(
                            child: CustomText(
                              text: status[index],
                              color: AppColor.white,
                              size: AppSize.xsmall,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
        return AppColor.lightBlack.withOpacity(0.9);
    }
  }

  Color getNameColor(int index) {
    switch (index) {
      case 0:
        return AppColor.lightBlue;
      case 1:
        return AppColor.orange.withOpacity(0.7);
      case 2:
        return AppColor.seaGreen;
      case 3:
        return AppColor.blue;
      case 4:
        return AppColor.lightBlue;
      case 5:
        return AppColor.orange.withOpacity(0.7);
      case 6:
        return AppColor.seaGreen;
      case 7:
        return AppColor.lightBlue;
      default:
        return AppColor.lightBlack.withOpacity(0.9);
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
        border: Border.all(color: AppColor.black),
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
          CustomSize(width: width * 0.01),
          Expanded(
            child: FittedBox(
              child: CustomText(
                text: value,
                color: AppColor.dimBlack,
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
                  color: AppColor.dimBlack,
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
