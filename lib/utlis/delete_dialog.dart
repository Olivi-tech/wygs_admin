import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/utlis/app_utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';

deleteDialog(BuildContext context, String collectionName) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: SvgPicture.asset(
          AppSvgs.danger,
          width: 50,
          height: 60,
        ),
        content: const SizedBox(
          height: 80,
          child: Column(
            children: [
              Text(
                'Are You Sure',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                'Are you sure? you want to delete this data.',
                style: TextStyle(
                  fontSize: AppSize.meddium,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'This cannot be undone.',
                style: TextStyle(
                  fontSize: AppSize.meddium,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 130,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.black,
                  textColor: AppColor.black,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: CustomButton(
                  onPressed: () {
                    FirestoreServices.deleteUserCollection(collectionName);
                    toastMessage('Data Deleted Successfully');
                    Future.delayed(const Duration(seconds: 2))
                        .then((value) => Navigator.pop(context));
                  },
                  text: 'Delete',
                  backgroundColor: const Color(0xFFFF4B61),
                  borderColor: const Color(0xFFFF4B61),
                  textColor: AppColor.white,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

deleteDocumentDialog(
    BuildContext context, String userId, String collectionName) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: SvgPicture.asset(
          AppSvgs.danger,
          width: 50,
          height: 60,
        ),
        content: const SizedBox(
          height: 80,
          child: Column(
            children: [
              Text(
                'Are You Sure',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                'Are you sure? you want to delete this data.',
                style: TextStyle(
                  fontSize: AppSize.meddium,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'This cannot be undone.',
                style: TextStyle(
                  fontSize: AppSize.meddium,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                width: 130,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.black,
                  textColor: AppColor.black,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: CustomButton(
                  onPressed: () {
                    FirestoreServices.deleteUserDocument(userId, collectionName)
                        .then((value) {
                      toastMessage('Data Deleted Successfully');
                      Navigator.pop(context);
                    });
                  },
                  text: 'Delete',
                  backgroundColor: const Color(0xFFFF4B61),
                  borderColor: const Color(0xFFFF4B61),
                  textColor: AppColor.white,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
