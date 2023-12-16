import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class BillingManagementScreen extends StatelessWidget {
  const BillingManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> status = [
      'Pending',
      'Paid',
      'Paid',
      'Pending',
      'Paid',
      'Paid',
      'Paid',
      'Pending',
      'Paid',
      'Paid',
      'Paid',
    ];
    List<String> names = [
      'John Doe',
      'Esther Howard',
      'Leslie Alexander',
      'Guy Hawkins',
      'Brooklyn Simmons',
      'Jacob Jones',
      'Ronald Richards',
      'Annette Black',
      'Marvin McKinney',
      'Theresa Webb',
      'Courtney Henry',
    ];
    List<String> subscriptionPlan = [
      'Premium',
      'Basic',
      'Professional',
      'Premium',
      'Premium',
      'Professional',
      'Basic',
      'Premium',
      'Premium',
      'Professional',
      'Basic',
    ];
    List<String> paymentType = [
      'Yearly',
      'Monthly',
      'Yearly',
      'Yearly',
      'Monthly',
      'Yearly',
      'Monthly',
      'Yearly',
      'Monthly',
      'Yearly',
      'Monthly',
    ];
    List<String> price = [
      '\$20/month',
      '\$20/month',
      '\$180/month',
      '\$20/month',
      '\$20/month',
      '\$20/month',
      '\$180/month',
      '\$20/month',
      '\$20/month',
      '\$20/month',
      '\$180/month',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15, left: 25),
          child: CustomText(
            text: 'User’s Subscription Management',
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
                  columnSpacing: MediaQuery.of(context).size.width * .073,
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
                          text: 'Invoice ID',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    )),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Name',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Subcription Plan',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Type',
                          color: AppColor.lightBlack,
                          size: AppSize.small,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DataColumn(
                      label: Expanded(
                        child: CustomText(
                          text: 'Price',
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
                                          color: AppColor.blackish
                                              .withOpacity(0.7)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CustomText(
                                    text: 'IN-2022-23345',
                                    color: AppColor.lightBlack.withOpacity(0.9),
                                    size: AppSize.xsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                text: subscriptionPlan[index],
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: paymentType[index],
                                color: const Color.fromARGB(255, 72, 50, 67)
                                    .withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: price[index],
                                color: AppColor.lightBlack.withOpacity(0.9),
                                size: AppSize.xsmall,
                                fontWeight: FontWeight.w400,
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
                          ]))),
            ),
          ),
        )
      ],
    );
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Pending':
      return AppColor.purple;
    case 'Paid':
      return const Color(0xFF1CD3B2);
    default:
      return AppColor.lightBlack.withOpacity(0.9);
  }
}
