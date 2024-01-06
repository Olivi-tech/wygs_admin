import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:guitar_songs/db_services/db_services.dart';
import 'package:guitar_songs/model/model.dart';
import 'package:guitar_songs/utlis/utlis.dart';
import 'package:guitar_songs/widgets/widgets.dart';
import '../constants/constants.dart';

questionDialogLeadGuitar(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Lead Guitar'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.dayOneQ_1, FontWeight.w600),
                        buildText('${data[0].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.dayOneQ_2, FontWeight.w600),
                        buildText('${data[0].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.dayOneQ_3, FontWeight.w600),
                        buildText('${data[0].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.dayOneQ_4, FontWeight.w600),
                        buildText('${data[0].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.dayOneQ_5, FontWeight.w600),
                        buildText('${data[0].faq['q_5']}', FontWeight.w400),
                        buildText(AppTexts.dayOneQ_6, FontWeight.w600),
                        buildText('${data[0].faq['q_6']}', FontWeight.w400),
                        buildText(AppTexts.dayOneQ_7, FontWeight.w600),
                        buildText('${data[0].faq['q_7']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

questionDialogRhythmGuitar(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Rhythm Guitar'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.dayTwoQ_1, FontWeight.w600),
                        buildText('${data[1].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.dayTwoQ_2, FontWeight.w600),
                        buildText('${data[1].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.dayTwoQ_3, FontWeight.w600),
                        buildText('${data[1].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.dayTwoQ_4, FontWeight.w600),
                        buildText('${data[1].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.dayTwoQ_5, FontWeight.w600),
                        buildText('${data[1].faq['q_5']}', FontWeight.w400),
                        buildText(AppTexts.dayTwoQ_6, FontWeight.w600),
                        buildText('${data[1].faq['q_6']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

questionDialogBassGuitar(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Bass Guitar'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.dayThreeQ_1, FontWeight.w600),
                        buildText('${data[2].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.dayThreeQ_2, FontWeight.w600),
                        buildText('${data[2].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.dayThreeQ_3, FontWeight.w600),
                        buildText('${data[2].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.dayThreeQ_4, FontWeight.w600),
                        buildText('${data[2].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.dayThreeQ_5, FontWeight.w600),
                        buildText('${data[2].faq['q_5']}', FontWeight.w400),
                        buildText(AppTexts.dayThreeQ_6, FontWeight.w600),
                        buildText('${data[2].faq['q_6']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

questionDialogDrums(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Bass Guitar'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.dayFourQ_1, FontWeight.w600),
                        buildText('${data[3].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.dayFourQ_2, FontWeight.w600),
                        buildText('${data[3].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.dayFourQ_3, FontWeight.w600),
                        buildText('${data[3].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.dayFourQ_4, FontWeight.w600),
                        buildText('${data[3].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.dayFourQ_5, FontWeight.w600),
                        buildText('${data[3].faq['q_5']}', FontWeight.w400),
                        buildText(AppTexts.dayFourQ_6, FontWeight.w600),
                        buildText('${data[3].faq['q_6']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

questionDialogVocal(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Vocal/Mic'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.dayFiveQ_1, FontWeight.w600),
                        buildText('${data[4].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.dayFiveQ_2, FontWeight.w600),
                        buildText('${data[4].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.dayFiveQ_3, FontWeight.w600),
                        buildText('${data[4].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.dayFiveQ_4, FontWeight.w600),
                        buildText('${data[4].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.dayFiveQ_5, FontWeight.w600),
                        buildText('${data[4].faq['q_5']}', FontWeight.w400),
                        buildText(AppTexts.dayFiveQ_6, FontWeight.w600),
                        buildText('${data[4].faq['q_6']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

questionDialogKeyboard(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Keyboard'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.daySixQ_1, FontWeight.w600),
                        buildText('${data[5].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.daySixQ_2, FontWeight.w600),
                        buildText('${data[5].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.daySixQ_3, FontWeight.w600),
                        buildText('${data[5].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.daySixQ_4, FontWeight.w600),
                        buildText('${data[5].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.daySixQ_5, FontWeight.w600),
                        buildText('${data[5].faq['q_5']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

questionDialogPiano(
    BuildContext context, TextEditingController controller, String documentId) {
  Stream<List<FaqModel>> fetchProgressData =
      FirestoreServices.fetchProgressUserDays(documentId);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColor.white,
        title: buildContainer('Piano'),
        content: SizedBox(
          width: 800,
          child: StreamBuilder(
            stream: fetchProgressData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(color: AppColor.blue),
                );
              } else if (snapshot.hasData) {
                List<FaqModel> data = snapshot.data!;
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildText(AppTexts.daySevenQ_1, FontWeight.w600),
                        buildText('${data[6].faq['q_1']}', FontWeight.w400),
                        buildText(AppTexts.daySevenQ_2, FontWeight.w600),
                        buildText('${data[6].faq['q_2']}', FontWeight.w400),
                        buildText(AppTexts.daySevenQ_3, FontWeight.w600),
                        buildText('${data[6].faq['q_3']}', FontWeight.w400),
                        buildText(AppTexts.daySevenQ_4, FontWeight.w600),
                        buildText('${data[6].faq['q_4']}', FontWeight.w400),
                        buildText(AppTexts.daySevenQ_5, FontWeight.w600),
                        buildText('${data[6].faq['q_5']}', FontWeight.w400),
                        buildText(AppTexts.daySevenQ_6, FontWeight.w600),
                        buildText('${data[6].faq['q_5']}', FontWeight.w400),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Reject',
                  backgroundColor: AppColor.white,
                  borderColor: AppColor.red,
                  textColor: AppColor.red,
                  textSize: AppSize.large,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 40,
                width: 110,
                child: CustomButton(
                  onPressed: () {
                    feedbackDialog(context, controller);
                  },
                  text: 'Pass',
                  backgroundColor: AppColor.blue,
                  borderColor: AppColor.blue,
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

Widget buildContainer(
  String text,
) {
  return Center(
    child: Text(
      text,
      style: const TextStyle(
        fontSize: AppSize.xlarge,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget buildText(String text, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
        color: AppColor.black, fontSize: AppSize.meddium, fontWeight: weight),
  );
}
