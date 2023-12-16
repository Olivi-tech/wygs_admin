import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class CommunityManagementScreen extends StatelessWidget {
  const CommunityManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> status = [
      'Active',
      'In Progress',
      'Active',
      'Paused',
      'In Progress',
      'Paused',
      'Active',
      'Active',
      'In Progress',
      'Active',
      'Active',
    ];
    List<String> names = [
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
      'John Doe',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15, left: 25),
          child: CustomText(
            text: 'Community’ Post Management',
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
                  columnSpacing: MediaQuery.of(context).size.width * .053,
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
                          text: 'Image',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    )),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Posted by',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Description',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Posting Date',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'No of Likes',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'No of Comments',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Status',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                  rows: List.generate(
                      names.length,
                      (index) => DataRow(cells: [
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
                                          color: AppColor.blackish
                                              .withOpacity(0.7)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                          AppImages.communityImage)),
                                ],
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: names[index],
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                maxLine: 2,
                                text:
                                    'Lorem ipsum dolor sit \namet, consectetur...',
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: '22/08/2023',
                                color: const Color.fromARGB(255, 72, 50, 67)
                                    .withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: '123k',
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: '25k',
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomContainer(
                                decoration: BoxDecoration(
                                  color: getColorStatus(status[index]),
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
                          ]))),
            ),
          ),
        )
      ],
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
      return AppColor.lightBlack.withOpacity(0.9);
  }
}
