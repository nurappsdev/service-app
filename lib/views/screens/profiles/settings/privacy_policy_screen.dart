

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../../controller/controllers.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});
  ProfileSetupController userController = Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
   userController.getAboutData(isAbouts: false, isTerms: false);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: CustomText(
          text: "Privacy",
          fontsize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.buttonPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
      // Obx((){
      //   var privacyList = userController.getAboutAndPrivacyTermsModel.value;
         Column(
             children: [
               Padding(
                 padding: EdgeInsets.all(12.r),
                 child: Container(
                   height: 700.h,
                   width: double.infinity,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(topLeft:Radius.circular(24.r),topRight: Radius.circular(24.r),bottomLeft: Radius.circular(24.r),bottomRight: Radius.circular(24.r)   ),
                       color: AppColors.whiteColor
                   ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 16.h,),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child:
                                Obx(()=>
                               userController.termAboutPrivacyResponseModel.value == ""? CustomLoader():
                                HtmlWidget(
                                     "${userController.termAboutPrivacyResponseModel.value.description ?? "N/A"}",

                                      textStyle: TextStyle(
                                        fontFamily: "Poppins-Regular",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 18.sp,

                                      )
                                  ),
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                         ),
               ),
             ],
           ),

      // }),
    );
  }
}
