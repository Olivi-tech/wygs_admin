// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:guitar_songs/constants/constants.dart';
// import 'package:guitar_songs/widgets/widgets.dart';

// class Rough extends StatelessWidget {
//   const Rough({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Container(
//           decoration: BoxDecoration(
//             color: AppColor.white,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: AppColor.jetBlack),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: customRowMainContainer(height * 0.05, width),
//                 ),
//                 const Divider(thickness: 1, indent: 1),
//                 customContainer(
//                     height * 0.05,
//                     double.infinity,
//                     'John Doe',
//                     '04/07',
//                     '03/07',
//                     '07/07',
//                     '04/07',
//                     '06/07',
//                     '04/07',
//                     '05/07'),
//                 const Divider(thickness: 1, indent: 1),
//                 customContainer(
//                     height * 0.05,
//                     double.infinity,
//                     'Samntha Rod',
//                     '04/07',
//                     '03/07',
//                     '07/07',
//                     '04/07',
//                     '06/07',
//                     '04/07',
//                     '05/07'),
//                 const Divider(thickness: 1, indent: 1),
//                 customContainer(
//                     height * 0.05,
//                     double.infinity,
//                     'George Belly',
//                     '04/07',
//                     '03/07',
//                     '07/07',
//                     '04/07',
//                     '06/07',
//                     '04/07',
//                     '05/07'),
//                 const Divider(thickness: 1, indent: 1),
//                 customContainer(
//                     height * 0.05,
//                     double.infinity,
//                     'Laura Lam',
//                     '04/07',
//                     '03/07',
//                     '07/07',
//                     '04/07',
//                     '06/07',
//                     '04/07',
//                     '05/07'),
//                 const Divider(thickness: 1, indent: 1),
//                 customContainer(
//                     height * 0.05,
//                     double.infinity,
//                     'Mycial Archid',
//                     '04/07',
//                     '03/07',
//                     '07/07',
//                     '04/07',
//                     '06/07',
//                     '04/07',
//                     '05/07'),
//               ],
//             ),
//           )),
//     );
//   }

//   customRowMainContainer(
//     double? height,
//     double? width,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Flexible(
//           flex: 2,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 3),
//                 child: Container(
//                   height: 18,
//                   width: 18,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(color: AppColor.black.withOpacity(0.7)),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 5),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColor.indigo,
//                     //  color: getNameColor('George Belly'),
//                     borderRadius: BorderRadius.circular(36),
//                   ),
//                   height: 25,
//                   width: 25,
//                   child: Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: SvgPicture.asset(AppSvgs.userBold),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: CustomText(
//                   text: 'Name',
//                   color: AppColor.indigo.withOpacity(0.9),
//                   size: AppSize.small,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Lead Guitar',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Rhythm Guitar',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Bass Guitar',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Drums',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Vocal/Mic',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Keyboard',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: CustomText(
//             text: 'Piano',
//             color: AppColor.indigo.withOpacity(0.9),
//             size: AppSize.small,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   customContainer(
//       double? height,
//       double? width,
//       String name,
//       String leadGuitar,
//       String rhythmGuitar,
//       String bassGuitar,
//       String drums,
//       String mic,
//       String keyboard,
//       String piano) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Flexible(
//           flex: 2,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 5),
//                 child: Container(
//                   height: 18,
//                   width: 18,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(color: AppColor.black.withOpacity(0.7)),
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: AppColor.indigo,
//                   //  color: getNameColor('George Belly'),
//                   borderRadius: BorderRadius.circular(36),
//                 ),
//                 height: 25,
//                 width: 25,
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: SvgPicture.asset(AppSvgs.userBold),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: CustomText(
//                   text: name,
//                   color: AppColor.indigo.withOpacity(0.9),
//                   size: AppSize.xsmall,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: leadGuitar,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: rhythmGuitar,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: bassGuitar,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: drums,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: mic,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: keyboard,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.skyBlue,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             height: 23,
//             width: 50,
//             child: Center(
//               child: CustomText(
//                 text: piano,
//                 color: AppColor.indigo.withOpacity(0.9),
//                 size: AppSize.xsmall,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Color getNameColor(String name) {
//     String firstLetter = name.isNotEmpty ? name[0].trim() : "";
//     switch (firstLetter) {
//       case "A":
//         return AppColor.lightBlue;
//       case "B":
//         return AppColor.orange.withOpacity(0.7);
//       case "C":
//         return AppColor.seaGreen;
//       case "D":
//         return AppColor.blue;
//       case "E":
//         return AppColor.lightBlue;
//       case "F":
//         return AppColor.orange.withOpacity(0.7);
//       case "G":
//         return AppColor.seaGreen;
//       case "H":
//         return AppColor.blue;
//       case "I":
//         return AppColor.lightBlue;
//       case "P":
//         return AppColor.orange.withOpacity(0.7);
//       case "J":
//         return AppColor.seaGreen;
//       case "R":
//         return AppColor.blue;
//       case "N":
//         return AppColor.lightBlue;
//       case "M":
//         return AppColor.orange.withOpacity(0.7);
//       case "K":
//         return AppColor.seaGreen;
//       case "O":
//         return AppColor.blue;
//       default:
//         return AppColor.indigo.withOpacity(0.9);
//     }
//   }
// }
