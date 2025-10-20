

import 'package:careshiftapp/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {


  Map<String, String> serviceIcons = {
    "Companionship": AppIcons.compIcon,
    "Domestic Assistance": AppIcons.domesIcon,
    "Driving & Community Access": AppIcons.driveIcon,
    "Showering & Bathing: Partial Assistance": AppIcons.showerIcon,
    "Yard Maintenance": AppIcons.showerIcon,
  };

  final String shiptId = Get.arguments;
  FindJobController findJobController = Get.put(FindJobController());
  TextEditingController messageCNTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {


    findJobController.getOpenJobDetailsData(shiptId);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(text: "Job Details",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.buttonPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: AppColors.whiteColor,
          child: SingleChildScrollView(
            child: Obx(() {
              if(findJobController.isOpenDetails.value){
                return CustomLoader();
              }else if(findJobController.openJobDetailsResponseModel.value == true && findJobController.openJobDetailsResponseModel.value == "" ){
               return Center(child: CustomText(text: "No Data Available",),);
              }else{
                return Column(
                    children: [
                      Container(
                        height: 2, // Thickness of the divider
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300, // Divider color
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15), // Shadow color
                              blurRadius: 2,
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: "${ApiConstants.imageBaseUrl}${findJobController.openJobDetailsResponseModel.value.clientDetails?.image}",
                              height: 70.h,
                              width: 60.w,
                              boxFit: BoxFit.cover,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: findJobController.openJobDetailsResponseModel.value.clientDetails?.name ?? "N/A",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonPrimaryColor,),
                                CustomText(text: findJobController.openJobDetailsResponseModel.value.clientDetails?.address ?? "N/A",
                                  fontsize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttonPrimaryColor,)
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      ColoredHeader(
                        text: "  Description",
                        textAlign: TextAlign
                            .start, // or TextAlign.start, TextAlign.end, etc.
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            maxline: 10,
                            text: findJobController.openJobDetailsResponseModel.value.description ?? "N/A",),
                        ),
                      ),
                      SizedBox(height: 20.h),
        
                      ///------Summary-------------------------
                      ColoredHeader(
                        text: "  Summary ",
                        textAlign: TextAlign
                            .start, // or TextAlign.start, TextAlign.end, etc.
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.timeIcon),
                            SizedBox(width: 20.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: findJobController.openJobDetailsResponseModel.value.summary?.time ?? "N/A",
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14.sp,),
                                SizedBox(height: 6.h,),
                                CustomText(text: findJobController.openJobDetailsResponseModel.value.summary?.duration.toString() ?? "N/A",
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontsize: 12.sp,)
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Divider(),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.calendar_month,
                              color: AppColors.buttonPrimaryColor,),
                            SizedBox(width: 20.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (findJobController.openJobDetailsResponseModel.value.summary?.date != null)
                                  CustomText(
                                    text: DateFormat('EEEE').format(
                                      DateTime.parse(
                                        findJobController.openJobDetailsResponseModel.value.summary!.date!.toString(),
                                      ),
                                    ),
                                    color: AppColors.buttonPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontsize: 14.sp,
                                  )
                                else
                                  CustomText(
                                    text: 'N/A',
                                    color: AppColors.buttonPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontsize: 14.sp,
                                  ),
                                SizedBox(height: 6.h),
                                CustomText(
                                  text: findJobController.openJobDetailsResponseModel.value.summary?.date != null
                                      ? DateFormat('dd MMM, yyyy').format(
                                    DateTime.parse(
                                      findJobController.openJobDetailsResponseModel.value.summary!.date.toString(),
                                    ),
                                  )
                                      : 'N/A',
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontsize: 12.sp,
                                ),
                              ],
        
                            ),
                            SizedBox(width: 130.w,),
        
                            Container(
                              padding: EdgeInsets.only(
                                  right: 12, left: 12, top: 4, bottom: 4),
                              decoration: BoxDecoration(borderRadius: BorderRadius
                                  .circular(20.r), color: Color(0xffBFEAED),),
                              child: Center(child: CustomText(text: "${findJobController.openJobDetailsResponseModel.value.summary?.frequency}",)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Divider(),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppIcons.locationIcon),
                            SizedBox(width: 20.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: findJobController.openJobDetailsResponseModel.value.summary?.address ?? "N/A",
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontsize: 14.sp,),
                                SizedBox(height: 6.h,),
                                CustomText(text: findJobController.openJobDetailsResponseModel.value.summary?.postalCode.toString() ?? "N/A",
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontsize: 12.sp,)
                              ],
                            ),
                            SizedBox(width: 130.w,),
        
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Divider(),
                      ),
                      SizedBox(height: 20.h),
        
                      ///------Earning-------------------------
                      ColoredHeader(
                        text: "  Earning ",
                        textAlign: TextAlign
                            .start, // or TextAlign.start, TextAlign.end, etc.
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.dolarIcon),
                                SizedBox(width: 20.w,),
                                CustomText(text: "hourly Rate",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttonPrimaryColor,
                                )
        
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(text: "\$ ${findJobController.openJobDetailsResponseModel.value.earnings?.hourlyRate ?? "N/A" }",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttonPrimaryColor,),
                                CustomText(text: "per hour",
                                  fontsize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttonPrimaryColor,),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.dolarIcon),
                                SizedBox(width: 20.w,),
                                CustomText(text: "Travel Rate",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttonPrimaryColor,
                                )
        
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(text: "\$ ${findJobController.openJobDetailsResponseModel.value.earnings?.travelRate ?? "N/A"}",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttonPrimaryColor,),
                                CustomText(text: "per km",
                                  fontsize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.buttonPrimaryColor,),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.dolarIcon),
                                SizedBox(width: 20.w,),
                                CustomText(text: "Total Earnings",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttonPrimaryColor,
                                )
        
                              ],
                            ),
                            Column(
                              children: [
                                CustomText(text: "\$ ${findJobController.openJobDetailsResponseModel.value.earnings?.total ?? "N/A" }",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.buttonPrimaryColor,),
                                SizedBox(height: 4.h),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffBFEAED),
                                      borderRadius: BorderRadius.circular(30.r)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.h, vertical: 4.w),
                                    child: CustomText(text: findJobController.openJobDetailsResponseModel.value.summary?.frequency ?? "N/A",
                                      fontsize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.buttonPrimaryColor,),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
        
        
                      ///----------------Service-------------------------
                      ColoredHeader(
                        text: "  Service ",
                        textAlign: TextAlign
                            .start, // or TextAlign.start, TextAlign.end, etc.
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: (findJobController.openJobDetailsResponseModel.value.services?.isEmpty ?? true)
                            ? 60.h  // If services is null or empty, set the height to 100
                            : (findJobController.openJobDetailsResponseModel.value.services!.length * 80.h).clamp(60.h, 200.h),
                         //height:(findJobController.openJobDetailsResponseModel.value.services!.length * 80.h).clamp(60.h,200.h),
                        child: ListView.builder(
                          itemCount: findJobController.openJobDetailsResponseModel.value.services?.length ?? 0,
                          itemBuilder: (context, index) {
                            String serviceName = findJobController.openJobDetailsResponseModel.value.services![index];
                            String iconPath = serviceIcons[serviceName] ?? '';
        
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(iconPath),
                                      SizedBox(width: 20.w,),
                                      CustomText(text: serviceName,
                                        fontsize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.buttonPrimaryColor,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
        
                      ///----------------Requirements-------------------------
                      ColoredHeader(
                        text: "  Requirements ",
                        textAlign: TextAlign
                            .start, // or TextAlign.start, TextAlign.end, etc.
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        width: 340.w,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:      findJobController.openJobDetailsResponseModel.value.eligible == false? Color(0xFFFFEAEA):Color(0xFFEAF8F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildRow(findJobController.openJobDetailsResponseModel.value.requirements?.validId?.clientValue == true
                                ?Icons.check_circle : Icons.info, findJobController.openJobDetailsResponseModel.value.requirements?.validId?.clientValue == true
                                ? Colors.teal : Colors.black, 'Valid Id',
                                'Required'),
        
                            findJobController.openJobDetailsResponseModel.value.requirements?.policeCheck?.value == false ? SizedBox.shrink():  _buildRow(findJobController.openJobDetailsResponseModel.value.requirements?.policeCheck?.clientValue == true
                                ?Icons.check_circle : Icons.info, findJobController.openJobDetailsResponseModel.value.requirements?.validId?.clientValue == true
                                ? Colors.teal : Colors.black, 'Police Check',
                                findJobController.openJobDetailsResponseModel.value.requirements?.validId?.value == true ? 'Required':"Not Required"),
        
                         findJobController.openJobDetailsResponseModel.value.requirements?.ndisWorkerCheck?.value == false ? SizedBox.shrink():   _buildRow(findJobController.openJobDetailsResponseModel.value.requirements?.ndisWorkerCheck?.clientValue == true
                                ?Icons.check_circle : Icons.info, findJobController.openJobDetailsResponseModel.value.requirements?.validId?.clientValue == true
                                ? Colors.teal : Colors.black, 'NDIS Worker Screening Check',
                                findJobController.openJobDetailsResponseModel.value.requirements?.validId?.value == true ? 'Required':"Not Required"),
        
        
                            _buildRow(findJobController.openJobDetailsResponseModel.value.requirements?.policeCheck?.clientValue == true
                                ?Icons.check_circle : Icons.info, findJobController.openJobDetailsResponseModel.value.requirements?.validId?.clientValue == true
                                ? Colors.teal : Colors.black, 'Genders',
                                findJobController.openJobDetailsResponseModel.value.requirements?.gender?.value ?? "N/A"),
        
                            _buildRow(
                                findJobController.openJobDetailsResponseModel.value.requirements?.qualifications?.clientValue == true
                                    ?Icons.check_circle : Icons.info, findJobController.openJobDetailsResponseModel.value.requirements?.qualifications?.clientValue == true
                                ? Colors.teal : Colors.black, 'Qualifications',
                              findJobController.openJobDetailsResponseModel.value.requirements?.qualifications?.value ?? "N/A",),
        
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  // Icon to represent status (check or info)
                                  Icon(
                                    findJobController.openJobDetailsResponseModel.value.requirements?.language?.clientValue == true
                                        ? Icons.check_circle
                                        : Icons.info,
                                    color: findJobController.openJobDetailsResponseModel.value.requirements?.language?.clientValue == true
                                        ? Colors.teal
                                        : Colors.black,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 10.w),
        
                                  // Title Text ("Languages")
                                  Expanded(
                                    child: Text(
                                      "Languages",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
        
        
                                  // GridView to display languages
                                  Expanded(
                                    child: Container(
        
                                      height: 70.h,
                                     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Colors.black12,),
                                      width: double.infinity, //
                                      // Make sure the GridView takes up available width
                                      child: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,  // Number of columns in the grid
                                          crossAxisSpacing: 10.0, // Space between columns
                                          mainAxisSpacing: 16.0, // Space between rows
                                        ),
                                        itemCount: findJobController.openJobDetailsResponseModel.value.requirements?.language?.value?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          String? value = findJobController.openJobDetailsResponseModel.value.requirements?.language?.value?[index];
        
                                          // Ensure value is not null before rendering
                                          if (value != null) {
                                            return Card(
                                              color: Colors.black26,
                                              elevation: 0,
                                              child: Center(
                                                child: Text(
                                                  value,
                                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                                  textAlign: TextAlign.end, // Align the text to the end
                                                ),
                                              ),
                                            );
                                          } else {
                                            return SizedBox(); // Placeholder if value is null
                                          }
                                        },
                                      ),
                                    ),
                                  ),
        
                                ],
                              ),
                            )
        
                          ],
                        ),
                      ),
            ///------------------Are you available for this job?------------------------
                      findJobController.openJobDetailsResponseModel.value.eligible == true
                          ? SizedBox(
                        height: 320.h, // Adjust height as necessary
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20.h),
                            ColoredHeader(
                              text: "  Are you available for this job? ",
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 20.h),
        
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(() {
                                      return CustomButton(
                                        title: "Yes",
                                        onpress: () {
                                          findJobController.isYesSelected.value = true;
                                          findJobController.isMaybeSelected.value = false;
                                          findJobController.isNoSelected.value = false;
                                          messageCNTRL.text = "yes";
                                        },
                                        width: 110.w,
                                        titlecolor: AppColors.buttonPrimaryColor,
                                        color: findJobController.isYesSelected.value
                                            ? Colors.grey[400] /// Change color when selected
                                            : Colors.white,
                                      );
                                    }),
                                  ),
        
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(() {
                                      return CustomButton(
                                        title: "Maybe",
                                        onpress: () {
                                          findJobController.isYesSelected.value = false;
                                          findJobController.isMaybeSelected.value = true;
                                          findJobController.isNoSelected.value = false;
                                          messageCNTRL.text = ""; // Allow typing
                                        },
                                        width: 110.w,
                                        titlecolor: AppColors.buttonPrimaryColor,
                                        color: findJobController.isMaybeSelected.value
                                            ? Colors.grey[400] /// Change color when selected
                                            : Colors.white,
                                      );
                                    }),
                                  ),
        
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(() {
                                      return CustomButton(
                                        title: "No",
                                        onpress: () {
                                          findJobController.isYesSelected.value = false;
                                          findJobController.isMaybeSelected.value = false;
                                          findJobController.isNoSelected.value = true;
                                          messageCNTRL.text = "no";
                                        },
                                        width: 110.w,
                                        titlecolor: AppColors.buttonPrimaryColor,
                                        color: findJobController.isNoSelected.value
                                            ? Colors.grey[400] // Change color when selected
                                            : Colors.white,
                                      );
                                    }),
                                  ),
        
                                ],
                              ),
        
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Obx(()=>
                                 CustomTextField(
                                   readOnly: !findJobController.isMaybeSelected.value,
                                   controller: messageCNTRL,
                                  hintText: "Type a message here...(250 Character limit)",
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Obx(()=>
                              CustomButtonCommon(
                                loading: findJobController.isApplyLoading.value,
                                  title: "Apply", onpress: () {
                                  print(shiptId);
                                  findJobController.jobApply(
                                    messageCNTRL.text,
                                      shiptId,
                                     );
                              }
                              ),
                            ),
                          ],
                        ),
                      )
                          : Opacity(
                        opacity: 0.4, // Faded color effect when eligible is false
                        child: AbsorbPointer( // Disables the user interaction with input
                          absorbing: true, // Makes the input non-interactive
                          child: SizedBox(
                            height: 320.h, // Adjust height as necessary
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.h),
                                ColoredHeader(
                                  text: "  Are you available for this job? ",
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomButton(
                                        title: "Yes",
                                        onpress: () {},
                                        width: 110.w,
                                        titlecolor: AppColors.buttonPrimaryColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomButton(
                                        title: "Maybe",
                                        onpress: () {},
                                        width: 110.w,
                                        titlecolor: AppColors.buttonPrimaryColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomButton(
                                        title: "No",
                                        onpress: (){},
                                        width: 110.w,
                                        titlecolor: AppColors.buttonPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: CustomTextField(
                                    readOnly: false,
                                    controller: messageCNTRL,
                                    hintText: "Type a message here...(250 Character limit)",
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                CustomButtonCommon(title: "Apply", onpress: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
        
                      SizedBox(height: 20.h),
        
                    ]
                );
              }
        
            }
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildRow(IconData icon, Color iconColor, String label, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
           SizedBox(width: 10.w),
          Expanded(
            child: Text(label, style:  TextStyle(fontSize: 14.sp)),
          ),
          Text(value,
              style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
        ],
      ),
    );
  }

}
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class JobDetailsScreen extends StatelessWidget {
//   // Example API response
//   final Map<String, dynamic> apiResponse = {
//     "services": [
//       "Driving & Community Access",
//       "Showering & Bathing: Partial Assistance",
//     ],
//   };
//
//   // Map to associate services with icons
//   final Map<String, String> serviceIcons = {
//     "Companionship": "assets/icons/companion_icon.svg",
//     "Domestic Assistance": "assets/icons/domestic_assistance_icon.svg",
//     "Driving & Community Access": "assets/icons/drive_icon.svg",
//     "Showering & Bathing: Partial Assistance": "assets/icons/shower_icon.svg",
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Job Details"),
//       ),
//       body: ListView.builder(
//         itemCount: apiResponse['services'].length,
//         itemBuilder: (context, index) {
//           String serviceName = apiResponse['services'][index];
//           String iconPath = serviceIcons[serviceName] ?? '';
//
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     SvgPicture.asset(iconPath),
//                     SizedBox(width: 20.0),
//                     Text(
//                       serviceName,
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue, // Change color as per your requirement
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10.0),
//                 Divider(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
