
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/controllers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class CompleteWorkScreen extends StatefulWidget {
  const CompleteWorkScreen({super.key});

  @override
  State<CompleteWorkScreen> createState() => _CompleteWorkScreenState();
}

class _CompleteWorkScreenState extends State<CompleteWorkScreen> {

  TextEditingController shipTaskDateCNTRL = TextEditingController();
  TextEditingController noticeCNTRL = TextEditingController();
  TextEditingController incidentOccurredCNTRL = TextEditingController();
  TextEditingController duringTravelCNTRL = TextEditingController();
  TextEditingController cilometersCNTRL = TextEditingController();

  bool conditionChanged = false;
  bool incidentOccurred = false;
  bool duringTravel = false;

  String id = Get.arguments['id'];
  BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    print(id);

    return Scaffold(

      appBar: AppBar(

        title: CustomText(text: "Complete Shift Report",color: AppColors.whiteColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.primaryColor,
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
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
                children: [
                  SizedBox(height: 20.h),

                  ///-----shift task---------------------------
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: AppColors.whiteColor),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        CustomText(text: "What tasks did you complete during this shift?",maxline: 2,textAlign: TextAlign.start, color: AppColors.buttonPrimaryColor,fontsize: 14.sp,fontWeight: FontWeight.w600),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          borderRadio: 12.h,
                          controller: shipTaskDateCNTRL,
                          onTap: (){},
                          filColor: Color(0xffE7ECF2),
                          maxLine: 4,
                          hintText: "Type Here",
                          // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Shift task cannot be empty";
                            }
                            // if (!AppConstants.emailValidate.hasMatch(value)) {
                            //   return "Invalid email address";
                            // }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                ///--------Notice-----------------------
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      Text(
                        "Have you noticed any changes in the client's condition, behavior, or needs?",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      buildSegmentedControl(
                        yesSelected: conditionChanged,
                        onChange: (val) {
                          setState(() {
                            conditionChanged = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (conditionChanged) buildTextInput(titleText:  "If Yes, please describe:",allCONTRL: noticeCNTRL),
                SizedBox(height: 20.h),


                ///--------------------incidentOccurred---------------
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      Text(
                        "Did any incident occur during this shift?",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      buildSegmentedControl(
                        yesSelected: incidentOccurred,
                        onChange: (val) {
                          setState(() {
                            incidentOccurred = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (incidentOccurred) buildTextInput(titleText:  "If Yes, please describe:",allCONTRL: duringTravelCNTRL),

                SizedBox(height: 20.h),
                ///--------------------duringTravel---------------

                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      Text(
                        "Did you travel with the client during this shift?",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      buildSegmentedControl(
                        yesSelected: duringTravel,
                        onChange: (val) {
                          setState(() {
                            duringTravel = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (duringTravel) buildTextInput(titleText:  "If Yes, please specify the destination (s):",allCONTRL: incidentOccurredCNTRL),
                SizedBox(height: 20.h),



                    ],
            ),



                  ///-----shift task---------------------------
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color: AppColors.whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        CustomText(text: "How many kilometers did you travel (with the client only)?",maxline: 2,textAlign: TextAlign.start, color: AppColors.buttonPrimaryColor,fontsize: 14.sp,fontWeight: FontWeight.w600),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          borderRadio: 12.h,
                          controller: cilometersCNTRL,
                          onTap: (){},
                          keyboardType: TextInputType.number,
                          filColor: Color(0xffE7ECF2),
                          maxLine: 1,
                          hintText: "Type Here",
                          // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "cannot be empty";
                            }
                            // if (!AppConstants.emailValidate.hasMatch(value)) {
                            //   return "Invalid email address";
                            // }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  Obx(()=> CustomButtonCommon(
                      loading: bookingController.isJobCheckOut.value,
                      title: "Submit", onpress: (){
                        bookingController.jobCheckOut(
                            id,
                            shipTaskDateCNTRL.text,
                            noticeCNTRL.text,
                            incidentOccurredCNTRL.text,
                            duringTravelCNTRL.text,
                            cilometersCNTRL.text
                        );
                  })),
                  SizedBox(height: 20.h),

                ]
            ),
          ),
        ),
      ),
    );
  }

  final activeColor = Color(0xFF0F575D); // Dark teal from example
  final borderRadius = BorderRadius.circular(15);
  Widget buildToggleButton({
    required bool selected,
    required String text,
    required VoidCallback onTap,
    BorderRadiusGeometry? radius,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? activeColor : Colors.white,
            borderRadius: radius,
            border: Border.all(color: activeColor),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : activeColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSegmentedControl({
    required bool yesSelected,
    required void Function(bool) onChange,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.white,
      ),
      child: Row(
        children: [
          buildToggleButton(
            selected: yesSelected,
            text: "Yes",
            radius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              bottomLeft: Radius.circular(24.r),
            ),
            onTap: () => onChange(true),
          ),
          buildToggleButton(
            selected: !yesSelected,
            text: "No",
            radius: BorderRadius.only(
              topRight: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r),
            ),
            onTap: () => onChange(false),
          ),
        ],
      ),
    );
  }

  Widget buildTextInput({required String titleText, required TextEditingController allCONTRL}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:  10.h),
          CustomText(text: titleText,fontsize: 14.sp,color:AppColors.buttonPrimaryColor,),
          SizedBox(height:  10.h),
          // TextFormField(
          //   maxLines: 4,
          //   style: TextStyle(color: Color(0xFF7E8890)),
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //     hintText: hintText,
          //     hintStyle: TextStyle(color: Color(0xFF7E8890)),
          //   ),
          // ),
          CustomTextField(
            borderRadio: 12.h,
            controller: allCONTRL,
            onTap: (){},
            filColor: Color(0xffE7ECF2),
            maxLine: 4,
            hintText: "Type Here",
            // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
            validator: (value) {
              // if (value == null || value.isEmpty) {
              //   return "cannot be empty";
              }
            //   // if (!AppConstants.emailValidate.hasMatch(value)) {
            //   //   return "Invalid email address";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height:  10.h),
        ],
      ),
    );
  }
}
