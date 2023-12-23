import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/widgets/custom_dialouge.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BillingManagementScreen extends StatelessWidget {
  BillingManagementScreen({super.key});

  Stream<List<BillingModel>> billingStream =
      FirestoreServices.fetchBillingManagement();
  late BillingCheckProvider billingCheckProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = size.width;
    billingCheckProvider =
        Provider.of<BillingCheckProvider>(context, listen: false);
    return StreamBuilder(
      stream: billingStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CupertinoActivityIndicator(
            color: AppColor.blue,
          ));
        }
        if (snapshot.hasData) {
          List<BillingModel> billingData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 25),
                  child: CustomText(
                    text: 'User’s Subscription Management',
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
                              Provider.of<BillingCheckProvider>(context)
                                          .selectedIndices
                                          .length ==
                                      billingData.length
                                  ? AppColor.paleBlue
                                  : AppColor.white),
                        ),
                        columnSpacing: MediaQuery.of(context).size.width * .08,
                        columns: [
                          DataColumn(
                              label: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  billingCheckProvider.selectAll(billingData);
                                },
                                child: Consumer<BillingCheckProvider>(
                                  builder: (context, value, child) {
                                    return Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          color: value.selectedIndices.length ==
                                                  billingData.length
                                              ? AppColor.green
                                              : AppColor.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              value.selectedIndices.length ==
                                                      billingData.length
                                                  ? Border.all(
                                                      color: AppColor.green)
                                                  : Border.all(
                                                      color: AppColor.black
                                                          .withOpacity(0.7)),
                                        ),
                                        child: value.selectedIndices.length ==
                                                billingData.length
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
                                text: 'Invoice ID',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )),
                          const DataColumn(
                            label: Expanded(
                              child: CustomText(
                                text: 'Name',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: CustomText(
                                text: 'Subcription Plan',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: CustomText(
                                text: 'Type',
                                color: AppColor.indigo,
                                size: AppSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Expanded(
                              child: CustomText(
                                text: 'Price',
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
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Consumer<BillingCheckProvider>(
                                      builder: (context, value, child) {
                                        return value.selectedIndices.length ==
                                                billingData.length
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
                                                        const EdgeInsets.all(3.0),
                                                    child: SvgPicture.asset(
                                                        AppSvgs.delete),
                                                  ),
                                                ))
                                            : const SizedBox();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        rows: billingData
                            .asMap()
                            .entries
                            .map((MapEntry<int, BillingModel> entry) {
                          final int index = entry.key;
                          final BillingModel model = entry.value;
                          return DataRow(
                            color: MaterialStateColor.resolveWith(
                              (states) {
                                return Provider.of<BillingCheckProvider>(
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
                                        billingCheckProvider
                                            .toggleChecked(index);
                                      },
                                      child: Consumer<BillingCheckProvider>(
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
                                                    color: Colors.black
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
                                    CustomText(
                                      text: model.id ?? '',
                                      color: AppColor.indigo.withOpacity(0.9),
                                      size: AppSize.xsmall,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                CustomText(
                                  text: model.name ?? '',
                                  color: AppColor.indigo.withOpacity(0.9),
                                  size: AppSize.xsmall,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              DataCell(
                                CustomText(
                                  text: model.subscription ?? '',
                                  color: AppColor.indigo.withOpacity(0.9),
                                  size: AppSize.xsmall,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              DataCell(
                                CustomText(
                                  text: model.type ?? '',
                                  color: const Color.fromARGB(255, 72, 50, 67)
                                      .withOpacity(0.9),
                                  size: AppSize.xsmall,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              DataCell(
                                CustomText(
                                  text: model.price ?? '',
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
                                        color:
                                            getStatusColor(model.status ?? ''),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      height: 23,
                                      width: 77,
                                      child: Center(
                                        child: CustomText(
                                          text: model.status ?? '',
                                          color: AppColor.white,
                                          size: AppSize.xsmall,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Consumer<BillingCheckProvider>(
                                        builder: (context, value, child) {
                                          return value.selectedIndices.length ==
                                                  billingData.length
                                              ? const SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    billingCheckProvider
                                                        .toggleChecked(index);
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
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              customDialouge(context);
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
                ),
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

Color getStatusColor(String status) {
  switch (status) {
    case 'Pending':
      return AppColor.purple;
    case 'Paid':
      return const Color(0xFF1CD3B2);
    default:
      return AppColor.indigo.withOpacity(0.9);
  }
}
