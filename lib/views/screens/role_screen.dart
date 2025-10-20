

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/helpers.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(AppIcons.appLogo),
                ),
                SizedBox(height: 30.h,),
                CustomText(text: "What role are you looking for",fontsize: 24.sp, color: AppColors.whiteColor,fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomText(text: "Please choose one of the option below:",color: AppColors.whiteColor,fontWeight: FontWeight.w500),
                SizedBox(height: 30.h),
        
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20.w),
                  child: InkWell(
                    onTap: () async{
                      await PrefsHelper.setString(AppConstants.type, "carer");
                      Get.toNamed(AppRoutes.signUpScreen,preventDuplicates: false);
                    },
                    child: Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: AppColors.whiteColor),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            SizedBox(width: 10.w),
                            SvgPicture.asset(AppIcons.carerIcon,width: 70.w,height: 70.h,),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30.h),
                                CustomText(text: "Carer", color: Color(0xff0C4479), fontWeight: FontWeight.w600,fontsize: 24.sp),
                                SizedBox(height: 10.h),
                                CustomText(text: AppString.carerDes,color: Color(0xff072543), maxline: 5,fontsize: 11.sp,textAlign: TextAlign.start,),
                                SizedBox(height: 12.h,),
        
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                InkWell(
                  onTap: ()async{
                    await PrefsHelper.setString(AppConstants.type, "nurse");
                    Get.toNamed(AppRoutes.signUpScreen,preventDuplicates: false);
                  },
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: AppColors.whiteColor),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.regIcon,width: 74.w,height: 70.h,),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30.h),
                                CustomText(text: "Registered Nurse", color: Color(0xff0C4479), fontWeight: FontWeight.w600,fontsize: 24.sp),
                                SizedBox(height: 10.h),
                                CustomText(text: AppString.regDes,color: Color(0xff072543), maxline: 5,fontsize: 11.sp,textAlign: TextAlign.start,),
                                SizedBox(height: 12.h,),
        
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 14.h),
                InkWell(
                  onTap: ()async{
                    await
                    PrefsHelper.setString(AppConstants.type, "cleaner");
                    Get.toNamed(AppRoutes.signUpScreen,preventDuplicates: false);
                  },
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: AppColors.whiteColor),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.domIcon,width: 70.w,height: 70.h,),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30.h),
                                CustomText(text: "Domestic Cleaner", color: Color(0xff0C4479), fontWeight: FontWeight.w600,fontsize: 24.sp),
                                SizedBox(height: 10.h),
                                CustomText(text: AppString.domDes,color: Color(0xff072543), maxline: 5,fontsize: 11.sp,textAlign: TextAlign.start,),
                                SizedBox(height: 12.h,),
        
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
