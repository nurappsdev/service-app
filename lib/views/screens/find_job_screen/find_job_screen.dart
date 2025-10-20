
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class FindJobScreen extends StatefulWidget {
  const FindJobScreen({super.key});

  @override
  State<FindJobScreen> createState() => _FindJobScreenState();
}

class _FindJobScreenState extends State<FindJobScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(text: "Find a Job",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,

      ),
      body: Column(
        children: [
          Container(
            height: 2, // Thickness of the divider
            decoration: BoxDecoration(
              color: Colors.grey.shade300, // Divider color
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color
                  blurRadius: 2,
                  offset: Offset(0, 2), // Shadow position
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: List.generate(2, (index) {
                  bool isSelected = tabController.index == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabController.index = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.buttonPrimaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          index == 0 ? "Open Jobs" : "Applied Jobs",
                          style: TextStyle(
                            fontFamily: "Montserrat-Light",
                            color: isSelected ? Colors.white : AppColors.buttonPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                // ApplyLeave(tabController: tabController),
                OpenJobsScreen(tabController: tabController),
                ApplyJobScreen(tabController: tabController),
              ],
            ),
          ),

        ],
      ),


      // Container(
      //   width: double.infinity,
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 2, // Thickness of the divider
      //         decoration: BoxDecoration(
      //           color: Colors.grey.shade300, // Divider color
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.15), // Shadow color
      //               blurRadius: 2,
      //               offset: Offset(0, 2), // Shadow position
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 20.h),
      //       Container(
      //         padding: EdgeInsets.all(10.r),
      //         decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(14.r)),
      //         child: Row(
      //           children: [
      //             Image.asset('assets/images/profileImg.png'),
      //             SizedBox(width: 10.w,),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 CustomText(text: "Burwood, 2E45",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp),
      //                 SizedBox(height: 10.w,),
      //                 CustomText(text: "Thu, 09:00 am - 11:00 am",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500,fontsize: 14.sp),
      //                 SizedBox(height: 6.w,),
      //                 CustomText(text: "10 April, 2026 - One off",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500,fontsize: 14.sp),
      //                 SizedBox(height: 6.w,),
      //                 ElevatedButton.icon(
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: const Color(0xFFEAF8F9),
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(30.r),
      //                       ),
      //                       padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      //                     ),
      //                     onPressed: (){},
      //                     label:
      //                     CustomText(text: "Every 2 weeks",color: AppColors.buttonPrimaryColor,fontsize: 14.sp,fontWeight: FontWeight.w500,)
      //
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),

    );
  }
}
