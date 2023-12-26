import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(height, width, 'Day 01'),
                buildContainer(height, width, 'Day 02'),
                buildContainer(height, width, 'Day 03'),
                buildContainer(height, width, 'Day 04'),
                buildContainer(height, width, 'Day 05'),
                buildContainer(height, width, 'Day 06'),
                buildContainer(height, width, 'Day 07'),
              ],
            ),
            SizedBox(height: height * 0.05),
            buildQuestionText(
                '1.“Please jot down a first line for your song. Do not over think this step - just go for it. (*this line will change many times this \nweek, but the rest of your song will be easier to write if you can tell yourself you have a solid first line, tempo, and tone/feel\nfor your song to at least work with for now.)”'),
            SizedBox(height: height * 0.02),
            buildAnswerText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
            SizedBox(height: height * 0.02),
            buildQuestionText(
                '2.“Now try to jot down 2 ideas about the song that involve: character and theme. Do not over think. Responses can always \nbe revised.”'),
            SizedBox(height: height * 0.02),
            buildAnswerText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
            SizedBox(height: height * 0.02),
            buildQuestionText(
                '3.“Please jot down a first line for your song. Do not over think this step - just go for it. (*this line will change many times this \n      week, but the rest of your song will be easier to write if you can tell yourself you have a solid first line, tempo, and tone/feel\n for your song to at least work with for now.)”'),
            SizedBox(height: height * 0.02),
            buildAnswerText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
            SizedBox(height: height * 0.02),
            buildQuestionText(
                '4.“Now try to jot down 2 ideas about the song that involve: character and theme. Do not over think. Responses can always \n be revised.”'),
            SizedBox(height: height * 0.02),
            buildAnswerText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.red)),
                    child: const Center(
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: AppSize.meddium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.blue)),
                    child: const Center(
                      child: Text(
                        'Pass',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: AppSize.meddium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(double height, double width, String text) {
    return Container(
      height: height * 0.06,
      width: width * 0.07,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x23000000),
              blurRadius: 17,
              offset: Offset(0, 6),
              spreadRadius: 2,
            )
          ]),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: AppColor.black,
            fontSize: AppSize.meddium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildQuestionText(String question) {
    return Text(
      question,
      style: const TextStyle(
        color: AppColor.black,
        fontSize: AppSize.meddium,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildAnswerText(String answer) {
    return Text(
      answer,
      style: const TextStyle(
        color: AppColor.black,
        fontSize: AppSize.meddium,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
