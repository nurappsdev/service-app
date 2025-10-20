
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controllers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        height: Get.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: SvgPicture.asset(AppIcons.appLogo),
                ),
                SizedBox(height: 30.h,),
                CustomText(text: "Welcome Back!",fontsize: 24.sp, color: AppColors.whiteColor,fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomText(text: "Make sure that you already have an account.",color: AppColors.whiteColor,fontWeight: FontWeight.w500),
                SizedBox(height: 20.h),
                Image.asset(
                  AppImages.signInImg,
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
                          CustomText(text: "Password",color: Color(0xff0C4479), fontWeight: FontWeight.w500,fontsize: 14.sp),
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
                              if (!AppConstants.validatePassword(value)
                                  ) {
                                return "Password must contain letters, numbers, uppercase, and special characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h,),
                          InkWell(
                              onTap: (){
                                Get.toNamed(AppRoutes.forgotPassScreen,preventDuplicates: false,
                                    parameters: {
                                      'email': emailController.text
                                    }
                                );
                              },
                              child:

                              Padding(
                                padding:  EdgeInsets.only(left: 180.w),
                                child: Text(" Forgot Password",style: TextStyle(decoration: TextDecoration.underline,color: Color(0xff0C4479),
                                  decorationColor:Color(0xff0C4479),
                                    fontWeight: FontWeight.w500,fontSize: 14.sp),),
                              ),),
                         //     CustomText(text: "Forgot Password",left: 170, color: Color(0xff0C4479),textAlign: TextAlign.end, fontWeight: FontWeight.w500,fontsize: 14.sp)),
                          SizedBox(height: 20.h),
                          Obx(()=>
                             CustomButtonCommon(title: "SIGN IN",
                                 loading: authController.loadingLoading.value == true,
                                 onpress: (){
                              if(_formKey.currentState!.validate()){
                                TextInput.finishAutofillContext();
                                authController.loginHandle(
                                    email: emailController.text, password:  passwordController.text);
                              //  Get.toNamed(AppRoutes.allBottomBarScreen,preventDuplicates: false);
                              }
                            }),
                          ),
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(text: "Don’t have any account? ",fontsize: 12.sp,),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.roleScreen,preventDuplicates: false);
                                },
                                child: Text(" Sign Up",style: TextStyle(decoration: TextDecoration.underline,color: AppColors.primaryColor,
                                  decorationColor: AppColors.primaryColor,
                                  fontSize: 14.sp,),
                                ),


                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
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
