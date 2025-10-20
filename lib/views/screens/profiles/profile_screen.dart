import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileSetupController profileSetupController = Get.put(ProfileSetupController());
@override
  void initState() {
    // TODO: implement initState
  profileSetupController.getUserData();
  profileSetupController.fetchDocumentResponse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    height: Get.height,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:  BorderRadius.only(
                            bottomLeft: Radius.circular(24.r),
                            bottomRight: Radius.circular(24.r),
                          ),
                          child: Image.asset(
                            AppImages.profileCoverIcon, // your image
                            fit: BoxFit.cover,
                            height: 260.h,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  Positioned(
                      top: 40.h,
                      left: 30.w,
      
                      child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,))
                  ),
      
                  Positioned(
                      top: 100.h,
                      left: 8.w,
                      right: 8.w,
                      child: CustomText(text: "Profile",fontWeight: FontWeight.w600,fontsize: 32.sp,color: AppColors.whiteColor,)
                  ),
                  Positioned(
                    left: 8.w,
                    right: 8.w,
                    bottom: 420.h,
                    child:
                    Padding(
                      padding: EdgeInsets.all(100),
                      child: Obx(()=>
                         CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl:  "${ApiConstants.imageBaseUrl}${profileSetupController.getUserResponseModel.value.image}",
                          height: 120.h,
                          width: 120.w,
                        ),
                      ),
                    ),
                    //
                    // Image.asset(AppImages.workChildImg)
                    // CircleAvatar(
                    //   radius: 50.r,
                    // //   backgroundImage: NetworkImage(
                    // //       'https://randomuser.me/api/portraits/men/32.jpg'),
                    // // ),
                    //   backgroundImage: AssetImage(AppImages.workChildImg)
                    // )
                  ),
      
                  Positioned(
                      top: 330.h,
                      left: 16.w,
                      right: 16.w,
                      child: Obx(()=>
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(text: "${profileSetupController.getUserResponseModel.value.firstName ?? "N/A"} ${profileSetupController.getUserResponseModel.value.lastName}",fontsize: 24.sp,fontWeight: FontWeight.w600,color: AppColors.whiteColor),
                                SizedBox(width: 6.w),
                                Image.asset(AppImages.starImg,height: 20.h,),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Center(child: CustomText(text: "${profileSetupController.getUserResponseModel.value.email
                                ?? "N/A"}",fontsize: 14.sp,fontWeight: FontWeight.w600,color: AppColors.whiteColor)),
                            SizedBox(height: 30.h),
      
      
                            CustomTextField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.none,
                              onTap: (){
                                Get.toNamed(AppRoutes.profileInfoEditScreen,
                                    arguments: profileSetupController.getUserResponseModel.value,
                                    preventDuplicates: false);
                              },
                              readOnly: true,
                              prefixIcon:Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(AppIcons.persionalIcon),
                              ),
                              suffixIcon: Icon(Icons.arrow_right),
                              hintText: "Personal Info ",
                              hinTextSize: 14.sp,
                            ),
                            SizedBox(height: 20.h,),
      
                            CustomTextField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.none,
                              onTap: (){Get.toNamed(AppRoutes.showUpdateProfileDocScreen,
                                  arguments: profileSetupController.documentResponseModel.value,
                                  preventDuplicates: false);},
                              readOnly: true,
                              prefixIcon:Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Icon(Icons.note_add,color: AppColors.primaryColor,),
                              ),
                              suffixIcon: Icon(Icons.arrow_right),
                              hintText: "My Documents ",
                              hinTextSize: 14.sp,
                            ),
                            SizedBox(height: 20.h,),
                            CustomTextField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.none,
                              onTap: (){
                                Get.toNamed(AppRoutes.settingScreen,preventDuplicates: false);
                              },
                              readOnly: true,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(AppIcons.docIcon),
                              ),
                              suffixIcon: Icon(Icons.arrow_right),
                              hintText: "Settings",
                              hinTextSize: 14.sp,
                            ),
                            SizedBox(height: 20.h,),
                            CustomTextField(
                              controller: TextEditingController(),
                              keyboardType: TextInputType.none,
                              onTap: (){
                                _showLogoutDialog(context);
                              },
                              readOnly: true,
                              prefixIcon:Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(AppIcons.logOutIcon),
                              ),
                              suffixIcon: Icon(Icons.arrow_right),
                              hintText: "Log Out",
                              hinTextSize: 14.sp,
                            ),
                            SizedBox(height: 20.h,),
                          ],
                        ),
                      )
      
                  )
      
                ],
              ),
      
              // Other tiles below
            ],
          ),
        ),
      ),
    );
  }

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
                    text: "Log Out",
                    fontsize: 22.sp,
                    color: AppColors.buttonPrimaryColor,
                    fontWeight: FontWeight.w600,
                    maxline: 2,
                  ),
                  SizedBox(height: 16.h,),
                  CustomText(
                    text: AppString.areYouSure,
                    fontsize: 14.sp,
                    fontWeight: FontWeight.w600,
                    maxline: 2,
                    color: Color(0xff3D6994),
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
                              color: AppColors.buttonPrimaryColor,
                              titlecolor: AppColors.whiteColor,
                              title: 'Log Out',
                              fontSize: 16.h,
                              onpress: () async {
                                //   profileController.promoCode.value = "";
                                await PrefsHelper.remove(AppConstants.bearerToken);
                                await PrefsHelper.remove(AppConstants.image);
                                await PrefsHelper.remove(AppConstants.firstname);
                                await PrefsHelper.remove(AppConstants.lastname);
                                await PrefsHelper.remove(AppConstants.email);
                                await PrefsHelper.remove(AppConstants.businessID);
                                await PrefsHelper.remove(AppConstants.type);

                                await PrefsHelper.remove(AppConstants.isHotDeals);
                                Get.toNamed(AppRoutes.signInScreen,preventDuplicates: false);
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