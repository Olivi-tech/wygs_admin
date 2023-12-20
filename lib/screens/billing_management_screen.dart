import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/providers/providers.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BillingManagementScreen extends StatelessWidget {
  BillingManagementScreen({super.key});

  Stream<List<BillingModel>> billingStream =
      ScreensServices.fetchBillingManagement();
  late BillingCheckProvider billingCheckProvider;

  @override
  Widget build(BuildContext context) {
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
                      columnSpacing: MediaQuery.of(context).size.width * .085,
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
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.7)),
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
                        const DataColumn(
                          label: Expanded(
                            child: CustomText(
                              text: 'Status',
                              color: AppColor.indigo,
                              size: AppSize.small,
                              fontWeight: FontWeight.w500,
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
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      billingCheckProvider.toggleChecked(index);
                                    },
                                    child: Consumer<BillingCheckProvider>(
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
                              CustomContainer(
                                decoration: BoxDecoration(
                                  color: getStatusColor(model.status ?? ''),
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
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
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
