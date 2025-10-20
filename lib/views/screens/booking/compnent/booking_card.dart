
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class BookingCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final String address;
  final double addressFontsize;

  const BookingCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.address,
    required this.addressFontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
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
          SizedBox(width: 8.w),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    color: AppColors.buttonPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontsize: 14.sp,
                  ),
                  SizedBox(height: 10.w),
                  CustomText(
                    text: time,
                    color: AppColors.buttonPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontsize: 12.sp,
                  ),
                  SizedBox(height: 6.w),
                  CustomText(
                    text: address,
                    textAlign: TextAlign.start,
                    color: AppColors.buttonPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontsize: addressFontsize,
                    maxline: 2,
                  ),
                  SizedBox(height: 10.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

