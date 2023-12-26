// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:guitar_songs/constants/constants.dart';
// import 'package:guitar_songs/db_services/db_services.dart';
// import 'package:guitar_songs/model/guest_model.dart';
// import 'package:guitar_songs/providers/providers.dart';
// import 'package:guitar_songs/widgets/widgets.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class GuestManagementScreen extends StatefulWidget {
//   const GuestManagementScreen({super.key});

//   @override
//   State<GuestManagementScreen> createState() => _GuestManagementScreenState();
// }

// class _GuestManagementScreenState extends State<GuestManagementScreen> {
//   Stream<List<GuestModel>> guestStream =
//       FirestoreServices.fetchGuestManagement();

//   late GuestCheckProvider guestCheckProvider;

//   @override
//   Widget build(BuildContext context) {
//     guestCheckProvider =
//         Provider.of<GuestCheckProvider>(context, listen: false);
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;

//     return StreamBuilder(
//         stream: guestStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//                 child: CupertinoActivityIndicator(
//               color: AppColor.blue,
//             ));
//           } else if (snapshot.hasData) {
//             List<GuestModel> guestData = snapshot.data!;
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Gap(height * 0.04),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 22),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         height: height * 0.07,
//                         width: width * 0.12,
//                         child: CustomButton(
//                           onPressed: () {},
//                           text: 'Invite Member',
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top: 15, left: 25),
//                     child: CustomText(
//                       text: 'Guest User’s Management',
//                       color: AppColor.blackish,
//                       size: AppSize.large,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20, right: 20, top: 20, bottom: 30),
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: AppColor.white,
//                         border: Border.all(color: AppColor.jetBlack),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: DataTable(
//                           columnSpacing:
//                               MediaQuery.of(context).size.width * 0.095,
//                           columns: [
//                             DataColumn(
//                               label: Row(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       guestCheckProvider.selectAll(guestData);
//                                     },
//                                     child: Consumer<GuestCheckProvider>(
//                                       builder: (context, value, child) {
//                                         return Container(
//                                             height: 18,
//                                             width: 18,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                   color: Colors.black
//                                                       .withOpacity(0.7)),
//                                             ),
//                                             child:
//                                                 value.selectedIndices.length ==
//                                                         guestData.length
//                                                     ? const Icon(
//                                                         Icons.check,
//                                                         size: 14,
//                                                         color: AppColor.blue,
//                                                       )
//                                                     : const SizedBox());
//                                       },
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   const CustomText(
//                                     text: 'Name',
//                                     color: AppColor.indigo,
//                                     size: AppSize.small,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const DataColumn(
//                               label: Expanded(
//                                 child: CustomText(
//                                   text: 'Email ID',
//                                   color: AppColor.indigo,
//                                   size: AppSize.small,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             const DataColumn(
//                               label: Expanded(
//                                 child: CustomText(
//                                   text: 'Joining Date',
//                                   color: AppColor.indigo,
//                                   size: AppSize.small,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             const DataColumn(
//                               label: Expanded(
//                                 child: CustomText(
//                                   text: 'Role',
//                                   color: AppColor.indigo,
//                                   size: AppSize.small,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                             DataColumn(
//                               label: Expanded(
//                                 child: Row(
//                                   children: [
//                                     const CustomText(
//                                       text: 'Status',
//                                       color: AppColor.indigo,
//                                       size: AppSize.small,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     Consumer<GuestCheckProvider>(
//                                       builder: (context, value, child) {
//                                         return value.selectedIndices.length ==
//                                                 guestData.length
//                                             ? SvgPicture.asset(AppSvgs.delete)
//                                             : const SizedBox();
//                                       },
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                           rows: guestData
//                               .asMap()
//                               .entries
//                               .map((MapEntry<int, GuestModel> entry) {
//                             final int index = entry.key;
//                             final GuestModel model = entry.value;
//                             return DataRow(
//                               cells: [
//                                 DataCell(
//                                   Row(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           guestCheckProvider
//                                               .toggleChecked(index);
//                                         },
//                                         child: Consumer<GuestCheckProvider>(
//                                           builder: (context, provider, child) =>
//                                               Container(
//                                             height: 18,
//                                             width: 18,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                   color: Colors.black
//                                                       .withOpacity(0.7)),
//                                             ),
//                                             child: provider.isSelected(index)
//                                                 ? const Icon(
//                                                     Icons.check,
//                                                     size: 14,
//                                                     color: AppColor.blue,
//                                                   )
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: nameColor(model.name),
//                                           borderRadius:
//                                               BorderRadius.circular(36),
//                                         ),
//                                         height: 25,
//                                         width: 25,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: SvgPicture.asset(
//                                               AppSvgs.userBold),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 5),
//                                       CustomText(
//                                         text: model.name,
//                                         color: AppColor.indigo.withOpacity(0.9),
//                                         size: AppSize.xsmall,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 DataCell(
//                                   CustomText(
//                                     text: model.email,
//                                     color: AppColor.indigo.withOpacity(0.9),
//                                     size: AppSize.xsmall,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 DataCell(
//                                   CustomText(
//                                     text: model.joiningDate,
//                                     color: AppColor.indigo.withOpacity(0.9),
//                                     size: AppSize.xsmall,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Container(
//                                     height: 25,
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                         color:
//                                             AppColor.skyBlue.withOpacity(0.6),
//                                         border: Border.all(
//                                           color: AppColor.blue.withOpacity(0.7),
//                                         ),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: const Center(
//                                       child: CustomText(
//                                         text: 'Guest',
//                                         color: AppColor.blue,
//                                         size: 10,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   Row(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: statusColor(model.status),
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                         ),
//                                         height: 23,
//                                         width: 77,
//                                         child: Center(
//                                           child: CustomText(
//                                             text: model.status,
//                                             color: AppColor.white,
//                                             size: AppSize.xsmall,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                       ),
//                                       Consumer<GuestCheckProvider>(
//                                         builder: (context, value, child) {
//                                           return value.selectedIndices.length ==
//                                                   guestData.length
//                                               ? const SizedBox()
//                                               : GestureDetector(
//                                                   onTap: () {
//                                                     guestCheckProvider
//                                                         .toggleChecked(index);
//                                                   },
//                                                   child: value.isSelected(index)
//                                                       ? Container(
//                                                           height: 40,
//                                                           width: 50,
//                                                           color: AppColor.white,
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(10.0),
//                                                             child: SvgPicture
//                                                                 .asset(AppSvgs
//                                                                     .delete),
//                                                           ),
//                                                         )
//                                                       : const SizedBox(),
//                                                 );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           } else {
//             return const Text('');
//           }
//         });
//   }
// }

// Color statusColor(String status) {
//   switch (status) {
//     case 'Approved':
//       return AppColor.green;
//     case 'Pending':
//       return AppColor.purple;
//     case 'Declined':
//       return AppColor.red;
//     default:
//       return AppColor.indigo.withOpacity(0.9);
//   }
// }

// Color nameColor(String name) {
//   String firstLetter = name.isNotEmpty ? name[0].trim() : "";
//   switch (firstLetter) {
//     case "A":
//       return AppColor.lightBlue;
//     case "B":
//       return AppColor.orange.withOpacity(0.7);
//     case "C":
//       return AppColor.seaGreen;
//     case "D":
//       return AppColor.blue;
//     case "E":
//       return AppColor.lightBlue;
//     case "F":
//       return AppColor.orange.withOpacity(0.7);
//     case "G":
//       return AppColor.seaGreen;
//     case "H":
//       return AppColor.blue;
//     case "I":
//       return AppColor.lightBlue;
//     case "P":
//       return AppColor.orange.withOpacity(0.7);
//     case "J":
//       return AppColor.seaGreen;
//     case "R":
//       return AppColor.blue;
//     case "N":
//       return AppColor.lightBlue;
//     case "M":
//       return AppColor.orange.withOpacity(0.7);
//     case "K":
//       return AppColor.seaGreen;
//     case "O":
//       return AppColor.blue;
//     default:
//       return AppColor.indigo.withOpacity(0.9);
//   }
// }
