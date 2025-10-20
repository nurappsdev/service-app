

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controllers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  TextEditingController conPassController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> resetForgotKey = GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
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
              CustomText(text: "Reset Your Password.",fontsize: 24.sp, color: AppColors.whiteColor,fontWeight: FontWeight.w600),
              SizedBox(height: 10.h),
              CustomText(text: "Password  must have 6-8 characters.",color: AppColors.whiteColor,fontWeight: FontWeight.w500),
              SizedBox(height: 20.h),
              Image.asset(
                AppImages.resetPassImg,
                fit: BoxFit.cover,
                height: 240.h,

              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(

                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: AppColors.whiteColor),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: resetForgotKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 20.h),
                          CustomText(text: "New Password",color: Color(0xff0C4479), fontWeight: FontWeight.w500,fontsize: 14.sp),
                          SizedBox(height: 10.h,),
                          CustomTextField(
                            controller: passwordController,
                            hintText: "Enter your password",
                            hinTextColor: Color(0xff072543),
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                                  .hasMatch(value)) {
                                return "Password must contain letters, numbers, uppercase, and special characters";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h),
                          CustomText(text: "Confirm Password",color: Color(0xff0C4479), fontWeight: FontWeight.w500,fontsize: 14.sp),
                          SizedBox(height: 10.h,),
                          CustomTextField(
                            controller: conPassController,
                            hintText: "Enter your Confirm password",
                            hinTextColor: Color(0xff072543),
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }else if(value != passwordController.text){

                                return "Password not match";
                              }
                                return null;


                            },
                          ),

                          SizedBox(height: 20.h),
                          Obx(()=>
                          CustomButtonCommon(title: "RESET",
                              loading: authController.isResetLoading.value == true,
                              onpress: (){
                                if(resetForgotKey.currentState!.validate()){
                                  authController.resetPassword(passwordController.text);
                                }
                          //    Get.toNamed(AppRoutes.signInScreen,preventDuplicates: false);
                            }),
                          ),
                          SizedBox(height: 12.h,),

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
    );
  }
}
