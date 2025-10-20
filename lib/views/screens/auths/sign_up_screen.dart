
import 'package:careshiftapp/views/widgets/custom_button_common.dart';
import 'package:careshiftapp/views/widgets/custom_text.dart';
import 'package:careshiftapp/views/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controller/controllers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController conPasswordController = TextEditingController();
AuthController authController = Get.find<AuthController>();
RxBool isChecked = false.obs;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passwordController.clear();
    conPasswordController.clear();
  }
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
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
                CustomText(text: "Join With Us!",fontsize: 24.sp, color: AppColors.whiteColor,fontWeight: FontWeight.w600),
                SizedBox(height: 10.h),
                CustomText(text: "Make sure your account keep secure",color: AppColors.whiteColor,fontWeight: FontWeight.w500),
                SizedBox(height: 20.h),
                Image.asset(
                 AppImages.signUpImg,
                  fit: BoxFit.cover,
                  height: 210.h,
                ),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
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
                            controller: conPasswordController,
                            hintText: "Enter your Confirm password",
                            hinTextColor: Color(0xff072543),
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }else if( value != passwordController.text){
                                return "Password Not Match";
                              }
                              else{
                                return null;
                            }

                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                    () => Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: AppColors.primaryColor,
                                  value: isChecked.value,
                                  onChanged: (value) {
                                    isChecked.value = value!;
                                  },
                                ),
                              ),
                              RichText(
                                text:  TextSpan(
                                  text: 'I agree with ',
                                  style: TextStyle(color: Colors.black,fontSize: 12.sp),
                                  children: [
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline,
                                          fontSize: 12.sp
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                        Get.toNamed(AppRoutes.termAndConScreen,preventDuplicates: false);
                                      // Add your custom logic for the Terms & Conditions tap event
                                      print('Terms & Conditions tapped');
                                    },
                                    ),
                                    TextSpan(
                                      text: ' & ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline,
                                          fontSize: 12.sp
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                        Get.toNamed(AppRoutes.aboutScreen,preventDuplicates: false);
                                          // Add your custom logic for the Terms & Conditions tap event
                                          print('Privacy Policy');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Obx(()=>
                            CustomButtonCommon(title: "SIGN UP",
                                loading: authController.signUpLoading.value == true,
                                onpress: (){
                             // Get.toNamed(AppRoutes.verifyScreen,preventDuplicates: false);

                              if(_formKey.currentState?.validate() ?? false){
                                if(!isChecked.value){
                                  Get.snackbar("Terms and Conditions", "You must accept the Terms and Conditions",
                                      backgroundColor: AppColors.primaryColor,
                                      colorText: Colors.white);
                                  return;
                                }else
                                  {
                                    authController.signUpHandle(
                                        email: emailController.text,
                                        password: passwordController.text,

                                    );
                                  }
                              }

                            }),
                          ),
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(text: AppString.allReadyAccount,fontsize: 12.sp,),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.signInScreen,preventDuplicates: false);
                                },
                                child: Text(" Sign In",style: TextStyle(decoration: TextDecoration.underline,color: AppColors.primaryColor,
                                  decorationColor: AppColors.primaryColor,
                                  fontSize: 14.sp,),),
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
