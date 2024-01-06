import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class AppColorUtlis {
  static getNameColor(String name) {
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
      case "S":
        return AppColor.midnightBlue;
      case "U":
        return AppColor.lightRed;
      default:
        return AppColor.indigo.withOpacity(0.9);
    }
  }

  static getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColor.purple;
      case 'Paid':
        return const Color(0xFF1CD3B2);
      case 'Active':
        return AppColor.green;
      case 'In Progress':
        return AppColor.blue;
      case 'Paused':
        return AppColor.red;
      case 'Completed':
        return AppColor.green;

      default:
        return AppColor.indigo.withOpacity(0.9);
    }
  }
}
