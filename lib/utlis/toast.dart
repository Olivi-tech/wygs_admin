import 'package:fluttertoast/fluttertoast.dart';
import 'package:guitar_songs/constants/constants.dart';

class Utlis {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM_RIGHT,
        webBgColor: "4683C4",
        textColor: AppColor.white,
        fontSize: 16.0);
  }
}
