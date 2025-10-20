

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../find_job_screen/test_findJob_pazination.dart';

Widget bookingCardItem({
  required String imagePath,
  required String title,
  required String time,
  required String date,
  required String button1Title,
  required String button2Title,
}) {
  return Container(
    padding: EdgeInsets.all(10.r),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          imageUrl: imagePath,
          height: 70.h,
          width: 60.w,
          boxFit: BoxFit.cover,
          boxShape: BoxShape.circle,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.buttonPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.sp,
                ),
                SizedBox(height: 10.w),
                CustomText(
                  text: time,
                  color: AppColors.buttonPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontsize: 10.sp,
                ),
                SizedBox(height: 10.w),
                CustomText(
                  text: date,
                  color: AppColors.buttonPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontsize: 10.sp,
                ),
                SizedBox(height: 10.w),
                CustomButtonCommon(
                  title: button1Title,
                  onpress: () {},
                  fontSize: 12.sp,
                  height: 35.h,
                  width: 110.w,
                  color: Color(0xFFEAF8F9),
                  titlecolor: AppColors.buttonPrimaryColor,
                  allBorderRadius: BorderRadius.circular(24.r),
                ),
                SizedBox(height: 10.w),
                CustomButtonCommon(
                  title: button2Title,
                  allBorderRadius: BorderRadius.circular(10.r),
                  onpress: () {

                  },
                  fontSize: 10.sp,
                  width: 190.w,
                  height: 40.h,
                  color: Color(0xffEBEBEB),
                  titlecolor: Color(0xff5C82A5),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    )

  );
}
