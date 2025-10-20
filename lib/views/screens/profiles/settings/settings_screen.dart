
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/controllers.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
   ProfileSetupController userController = Get.put(ProfileSetupController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: CustomText(
          text: "Settings",
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Column(
              children: [
                // CustomTextField(
                //   controller: TextEditingController(),
                //   keyboardType: TextInputType.none,
                //   onTap: (){
                //     Get.toNamed(AppRoutes.profileInfoEditScreen,preventDuplicates: false);
                //   },
                //   readOnly: true,
                //   prefixIcon:Padding(
                //     padding: EdgeInsets.all(12.r),
                //     child: SvgPicture.asset(AppIcons.persionalIcon),
                //   ),
                //   suffixIcon: Icon(Icons.arrow_right),
                //   hintText: "Personal Info ",
                //   hinTextSize: 14.sp,
                // ),
                // SizedBox(height: 20.h,),
                //
                // CustomTextField(
                //   controller: TextEditingController(),
                //   keyboardType: TextInputType.none,
                //   onTap: (){Get.toNamed(AppRoutes.profileSetupDocScreen,preventDuplicates: false);},
                //   readOnly: true,
                //   prefixIcon:Padding(
                //     padding: EdgeInsets.all(12.r),
                //     child: Icon(Icons.note_add,color: AppColors.primaryColor,),
                //   ),
                //   suffixIcon: Icon(Icons.arrow_right),
                //   hintText: "My Documents ",
                //   hinTextSize: 14.sp,
                // ),
                // SizedBox(height: 20.h,),
                // CustomTextField(
                //   controller: TextEditingController(),
                //   keyboardType: TextInputType.none,
                //   onTap: (){
                //     Get.toNamed(AppRoutes.settingScreen,preventDuplicates: false);
                //   },
                //   readOnly: true,
                //   prefixIcon: Padding(
                //     padding: EdgeInsets.all(12.r),
                //     child: SvgPicture.asset(AppIcons.docIcon),
                //   ),
                //   suffixIcon: Icon(Icons.arrow_right),
                //   hintText: "Settings",
                //   hinTextSize: 14.sp,
                // ),
                // SizedBox(height: 20.h,),
                // CustomTextField(
                //   controller: TextEditingController(),
                //   keyboardType: TextInputType.none,
                //   readOnly: true,
                //   prefixIcon:Padding(
                //     padding: EdgeInsets.all(12.r),
                //     child: SvgPicture.asset(AppIcons.logOutIcon),
                //   ),
                //   suffixIcon: Icon(Icons.arrow_right),
                //   hintText: "Log Out",
                //   hinTextSize: 14.sp,
                // ),
                // SizedBox(height: 20.h,),

                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.changePassScreen,preventDuplicates: false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.passIcons,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 16.w),
                              CustomText(text: "Change Password",
                                fontsize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonPrimaryColor,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Icon(Icons.arrow_right)
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.privacyScreen,preventDuplicates: false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.privaciIcons,

                              ),
                              SizedBox(width: 16.w),
                              CustomText(text: "Privacy Policy",
                                fontsize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonPrimaryColor,
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(Icons.arrow_right)
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.termAndConScreen,preventDuplicates: false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color:AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.termsIcons,

                              ),
                              SizedBox(width: 16.w),
                              CustomText(text: "Terms Of Conditions",
                                fontsize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonPrimaryColor,
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(Icons.arrow_right)
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.aboutScreen,preventDuplicates: false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.aboutIcons,
                              ),
                              SizedBox(width: 16.w),
                              CustomText(text: "About Us",
                                fontWeight: FontWeight.w500,
                                fontsize: 14.sp,
                                color: AppColors.buttonPrimaryColor,
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(Icons.arrow_right)
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 26.h),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    text: "Delete Account",
                                    fontsize: 22.sp,
                                    color:AppColors.buttonPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                    maxline: 2,
                                  ),
                                  SizedBox(height: 16.h,),
                                  CustomText(
                                    text: AppString.areYouSure,
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    maxline: 2,
                                  ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 120.w,
                                          height: 40.h,
                                          child: CustomButton(
                                            title: 'Cancel',
                                            fontSize: 16.h,
                                            onpress: () {
                                              Get.back();
                                            },
                                            color: Colors.white,
                                            titlecolor: AppColors
                                                .buttonPrimaryColor,
                                          )),
                                      SizedBox(
                                          width: 120.w,
                                          height: 40.h,
                                          child: CustomButton(
                                              color: Colors.red,
                                              titlecolor: AppColors.whiteColor,
                                              title: 'Delete',
                                              fontSize: 16.h,
                                              onpress: () async {
                                                userController.deleteAccount();
                                                //   profileController.promoCode.value = "";
                                                await PrefsHelper.remove(AppConstants.bearerToken);
                                                await PrefsHelper.remove(AppConstants.userId);
                                                await PrefsHelper.remove(AppConstants.firstname);
                                                await PrefsHelper.remove(AppConstants.lastname);
                                                await PrefsHelper.remove(AppConstants.image);
                                                await PrefsHelper.remove(AppConstants.email);
                                                await PrefsHelper.remove(AppConstants.businessID);
                                                await PrefsHelper.remove(AppConstants.type);
                                              })),
                                    ],
                                  )
                                ],
                              ),
                              elevation: 12.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(
                                      width: 1.w,
                                      color: AppColors.primaryColor)));
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.only(left: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.w,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red,),
                              SizedBox(width: 16.w),
                              CustomText(text: "Delete Account ",
                                fontsize: 14.sp,
                                color: AppColors.textColor4E4E4E,
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Icon(Icons.arrow_right)
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
  ///==============Delete======================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.w, vertical: 26.h),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "Delete Account",
                    fontsize: 22.sp,
                    color:Colors.red,
                    fontWeight: FontWeight.w600,
                    maxline: 2,
                  ),
                  SizedBox(height: 16.h,),
                  CustomText(
                    text: AppString.areYouSure,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w600,
                    maxline: 2,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 120.w,
                          height: 40.h,
                          child: CustomButton(
                            title: 'Cancel',
                            fontSize: 16.h,
                            onpress: () {
                              Get.back();
                            },
                            color: Colors.white,
                            titlecolor: AppColors
                                .primaryColor,
                          )),
                      SizedBox(
                          width: 120.w,
                          height: 40.h,
                          child: CustomButton(
                              color: Colors.red,
                              titlecolor: AppColors.whiteColor,
                              title: 'Delete',
                              fontSize: 16.h,
                              onpress: () async {
                                  userController.deleteAccount();
                                //   profileController.promoCode.value = "";
                                await PrefsHelper.remove(AppConstants.bearerToken);
                                await PrefsHelper.remove(AppConstants.userId);
                                await PrefsHelper.remove(AppConstants.firstname);
                                await PrefsHelper.remove(AppConstants.lastname);
                                await PrefsHelper.remove(AppConstants.image);
                                await PrefsHelper.remove(AppConstants.email);
                                await PrefsHelper.remove(AppConstants.businessID);
                                await PrefsHelper.remove(AppConstants.type);
                              })),
                    ],
                  )
                ],
              ),
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                      width: 1.w,
                      color: AppColors.primaryColor)));
        });
    // Get.defaultDialog(
    //   title: 'Log Out',
    //   titleStyle: TextStyle(
    //       color: Colors.red,
    //       fontSize: 20.sp,
    //       fontWeight: FontWeight.bold),
    //   titlePadding: EdgeInsets.only(top: 20.h),
    //   contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    //   backgroundColor: AppColors.whiteColor,
    //   radius: 12.r,
    //   barrierDismissible: false,
    //   content: SizedBox(
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     height: 180.h,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         SizedBox(height: 10.h),
    //         Divider(
    //           color: AppColors.primaryColor.withOpacity(0.7),
    //           thickness: 1.h,
    //           indent: 25.w,
    //           endIndent: 25.w,
    //         ),
    //         SizedBox(height: 10.h),
    //         CustomText(
    //           text: 'Are you sure you want to log out of your account?',
    //           textAlign: TextAlign.center,
    //           fontsize: 16.sp,
    //           color: AppColors.textColor4E4E4E,
    //         ),
    //         SizedBox(height: 20.h),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             ElevatedButton(
    //               onPressed: () {
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor: AppColors.primaryColor,
    //                 overlayColor: Colors.green,
    //                 backgroundColor: Colors.white,
    //                 shadowColor: Colors.green,
    //                 fixedSize: Size(120.5.w, 60.h),
    //                 shape:  RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16.sp),
    //
    //                 ),
    //                 padding: EdgeInsets.symmetric(vertical: 18.h,
    //                     horizontal: 16.w),
    //               ),
    //               child: Text(
    //                 'Cancel',
    //                 style: TextStyle(fontSize: 16.sp),
    //               ),
    //             ),
    //             SizedBox(width: 10.w),
    //             ElevatedButton(
    //               onPressed: () {
    //                 //  Get.offAllNamed(AppRoutes.roleScreen);
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor: AppColors.whiteColor,
    //                 backgroundColor: Colors.red,
    //                 fixedSize: Size(130.5.w, 60.h),
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(16.sp),
    //                 ),
    //                 padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
    //               ),
    //               child: Text(
    //                 'Log Out',
    //                 style: TextStyle(fontSize: 16.sp),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
