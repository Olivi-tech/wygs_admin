import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guitar_songs/constants/constants.dart';

import '../utlis/utlis.dart';
import '../widgets/widgets.dart';

class CustomAppBar extends StatefulWidget {
  final TextEditingController controller;
  final SearchCallbackFunc setSearchValue;
  const CustomAppBar(
      {super.key, required this.controller, required this.setSearchValue});
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(
          color: AppColor.jetBlack,
        ),
      ),
      height: height * 0.1,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Color(0xFF424D57),
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  width: width * 0.17,
                  height: height * 0.07,
                  child: CustomTextField(
                    hintText: 'Search here',
                    controller: widget.controller,
                    onChanged: (query) {
                      widget.setSearchValue(query);
                    },
                    fillColor: AppColor.white,
                    borderColor: const Color(0xE5D1D9E6),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppSvgs.search),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0x190174BE),
                      borderRadius: BorderRadius.circular(100)),
                  height: height * 0.07,
                  width: 40,
                  child: const Center(
                    child: Text(
                      'SA',
                      style: TextStyle(
                        color: Color(0xFF0174BE),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text(
                  'Shakeel Awan',
                  style: TextStyle(
                    color: Color(0xFF0C356A),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
