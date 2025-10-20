


import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  AuthController authController = Get.find<AuthController>();
final GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  @override
  void initState(){
    emailController.text = Get.parameters['email'] ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: forgotKey,
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(AppIcons.appLogo),
                ),
                SizedBox(height: 30.h,),
                CustomText(text: "Forget Your Password?",fontsize: 24.sp, color: AppColors.whiteColor,fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomText(text: "Please enter the 6 digit verification code sent \nto your e-mail",color: AppColors.whiteColor,fontWeight: FontWeight.w500),
                SizedBox(height: 20.h),
                Image.asset(
                  AppImages.forgotImg,
                  fit: BoxFit.cover,
                  height: 280.h,

                ),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: AppColors.whiteColor),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          CustomText(text: "Email",color: Color(0xff0C4479), fontWeight: FontWeight.w500,fontsize: 14.sp),
                          SizedBox(height: 10.h,),
                          CustomTextField(
                            controller: emailController,
                            hintText: "Enter your email",
                            hinTextColor: Color(0xff072543),
                            isEmail: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email cannot be empty";
                              }
                              if (!AppConstants.emailValidate.hasMatch(value)) {
                                return "Invalid email address";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h),

                          Obx(()=>
                            CustomButtonCommon(title: "GET CODE",
                                loading: authController.forgotLogin.value == true,
                                onpress: (){
                              if(forgotKey.currentState!.validate()){

                                //  Get.toNamed(AppRoutes.emailVerifyScreen,preventDuplicates: false);
                                // PrefsHelper.setString(AppConstants.email, emailController.text);
                                // // Get.toNamed(AppRoutes.emailVerifyScreen,preventDuplicates: false,arguments: true);
                                // // Get.to(()=>EmailVerifyScreen(isUpdatePassScreen: true,));
                                authController.forgotHandle(emailController.text, "forgot");
                              }}),
                          ),
                          SizedBox(height: 12.h,),

                        ],
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
