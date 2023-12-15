import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class GuestManagementScreen extends StatelessWidget {
  const GuestManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    List<String> names = [
      'John Doe',
      'Pam Bessely',
      'Samantha Rodd',
      'George Belly',
      'John Doe',
      'Pam Bessely',
      'Samantha Rodd',
      'George Belly',
      'John Doe',
      'Pam Bessely',
      'Samantha Rodd',
    ];
    List<String> status = [
      'Approved',
      'Pending',
      'Declined',
      'Approved',
      'Pending',
      'Declined',
      'Approved',
      'Pending',
      'Declined',
      'Pending',
      'Declined',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(height * 0.04),
        Padding(
          padding: const EdgeInsets.only(right: 22),
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: height * 0.07,
              width: width * 0.12,
              child: CustomButton(
                onPressed: () {},
                text: 'Invite Member',
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15, left: 25),
          child: CustomText(
            text: 'Guest User’s Management',
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
            child: DataTable(
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
                              color: AppColor.blackish.withOpacity(0.9)),
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
                  )),
                  const DataColumn(
                    label: Expanded(
                      child: CustomText(
                        text: 'Email ID',
                        color: AppColor.lightBlack,
                        size: AppSize.small,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Expanded(
                      child: CustomText(
                        text: 'Joining Date',
                        color: AppColor.lightBlack,
                        size: AppSize.small,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Expanded(
                      child: CustomText(
                        text: 'Role',
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
                  ),
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
                                        color:
                                            AppColor.blackish.withOpacity(0.7)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CustomContainer(
                                  decoration: BoxDecoration(
                                    color: nameColor(index),
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
                                CustomText(
                                  text: names[index],
                                  color: AppColor.lightBlack.withOpacity(0.9),
                                  size: AppSize.xsmall,
                                  fontWeight: FontWeight.w400,
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
                            CustomContainer(
                              height: 25,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: AppColor.skyBlue.withOpacity(0.6),
                                  border: Border.all(
                                    color: AppColor.blue.withOpacity(0.7),
                                  ),
                                  borderRadius: BorderRadius.circular(4)),
                              child: const Center(
                                child: CustomText(
                                  text: 'Guest',
                                  color: AppColor.blue,
                                  size: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            CustomContainer(
                              decoration: BoxDecoration(
                                color: statusColor(status[index]),
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
        )
      ],
    );
  }
}

Color statusColor(String status) {
  switch (status) {
    case 'Approved':
      return AppColor.green;
    case 'Pending':
      return AppColor.purple;
    case 'Declined':
      return AppColor.red;
    default:
      return AppColor.lightBlack.withOpacity(0.9);
  }
}

Color nameColor(int index) {
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
    case 8:
      return AppColor.orange.withOpacity(0.7);
    case 9:
      return AppColor.seaGreen;
    case 10:
      return AppColor.lightBlue;
    default:
      return AppColor.lightBlack.withOpacity(0.9);
  }
}
