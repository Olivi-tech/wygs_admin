import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/custom_text.dart';

customDialouge(BuildContext context) {
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
              CustomText(
                text: 'Are You Sure',
                size: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              CustomText(
                text: 'Are you sure? you want to delete this data.',
                size: AppSize.meddium,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: 'This cannot be undone.',
                size: AppSize.meddium,
                color: Colors.black,
                fontWeight: FontWeight.w400,
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: AppColor.black),
                    backgroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child: CustomText(
                    text: 'Cancel',
                    size: AppSize.large,
                    color: AppColor.black,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF4B61)),
                    backgroundColor: const Color(0xFFFF4B61),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                      child: CustomText(
                    text: 'Delete',
                    size: AppSize.large,
                    color: AppColor.white,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
