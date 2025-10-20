
import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController _controller = TextEditingController();
  AuthController authController = Get.find<AuthController>();
@override
  void dispose() {
    // TODO: implement dispose
  _controller.clear();
    super.dispose();
  }
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
              CustomText(text: "Enter Verification Code",fontsize: 24.sp, color: AppColors.whiteColor,fontWeight: FontWeight.w600),
              SizedBox(height: 10.h),
              CustomText(text: "Please enter the 6 digit verification code sent \nto your e-mail",color: AppColors.whiteColor,fontWeight: FontWeight.w500),
              SizedBox(height: 20.h),
              Image.asset(
                AppImages.verifyImg,
                fit: BoxFit.cover,
                height: 280.h,

              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: AppColors.whiteColor),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        // CustomText(text: "Email",color: Color(0xff0C4479), fontWeight: FontWeight.w500,fontsize: 14.sp),
                        // SizedBox(height: 10.h,),
                        CustomPinCodeTextField(textEditingController: _controller),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Didn’t get the code?",color: Color(0xff0C4479), fontWeight: FontWeight.w300,fontsize: 14.sp),
                           // CustomText(text: "Rsend",color: Color(0xff0C4479), fontWeight: FontWeight.w500,fontsize: 16.sp)
                            GestureDetector(
                              onTap: () async{
                                String? emails = await PrefsHelper.getString(AppConstants.email);
                                authController.resendOTP(email: emails);
                              },
                              child: Text(" Resend",style: TextStyle(decoration: TextDecoration.underline,color: AppColors.primaryColor,
                                decorationColor: AppColors.primaryColor,
                                fontSize: 14.sp,)),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        Obx(()=>
                           CustomButtonCommon(title: "VERIFY",
                              loading:authController.verifyLoading.value == true,
                              onpress: (){
    // if(Get.parameters['screenType'] == 'forgot'){}else{
    //
    // }
                             authController.otpVerify(_controller.text);
                           // Get.toNamed(AppRoutes.resetPassScreen,preventDuplicates: false);
                          }),
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
    );
  }
}

