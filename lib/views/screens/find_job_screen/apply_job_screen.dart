
import 'package:careshiftapp/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  final List<Map<String, String>> bookings = [
    {
      'imagePath': 'assets/images/profileImg.png',
      'title': 'Parramatta, 5B12',
      'time': 'Fri, 02:00 pm - 04:00 pm',
      'date': '27 Mar, 2025',
      'button1Title': 'One off',
      'button2Title': 'View Status',
    },   {
      'imagePath': 'assets/images/profileImg.png',
      'title': 'Parramatta, 5B12',
      'time': 'Fri, 02:00 pm - 04:00 pm',
      'date': '27 Mar, 2025',
      'button1Title': 'One off',
      'button2Title': 'View Status',
    }, {
      'imagePath': 'assets/images/profileImg.png',
      'title': 'Parramatta, 5B12',
      'time': 'Fri, 02:00 pm - 04:00 pm',
      'date': '27 Mar, 2025',
      'button1Title': 'One off',
      'button2Title': 'View Status',
    }, {
      'imagePath': 'assets/images/profileImg.png',
      'title': 'Parramatta, 5B12',
      'time': 'Fri, 02:00 pm - 04:00 pm',
      'date': '27 Mar, 2025',
      'button1Title': 'One off',
      'button2Title': 'View Status',
    },

  ];

  int _clickCount = 0;

  void _handleButtonClick(BuildContext context) {
    setState(() {
      _clickCount++;
    });

    switch (_clickCount % 3) {
      case 1:
        _showFiledDialog(context);
        break;
      case 2:
        _showGotShiftDialog(context);
        break;
      case 0:
        _showApplicantDialog(context);
        break;
    }
  }



  ScrollController _scrollController = ScrollController();

  FindJobApplyController findJobApplyController = Get.put(FindJobApplyController());
  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  @override
  void didChangeDependencies() {
    // Refresh data when returning to this screen
    super.didChangeDependencies();
    findJobApplyController.getJobAppliedWithModalData(); // Make sure this loads the data
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        findJobApplyController.loadMore();
        print("load more true");
      }
    });
  }


  // Method to refresh the job applied data
  Future<void> _onRefresh() async {
    findJobApplyController.page.value = 1;
    await findJobApplyController.getJobAppliedWithModalData(); // Fetch fresh data
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: Obx((){
                if(findJobApplyController.isJob.value){

                  return Shimmer.fromColors(
             baseColor: Colors.grey[300]!,
             highlightColor: Colors.grey[100]!,
             child:  ListView.builder(
                 itemCount: 4, // Just a placeholder for shimmer items
                 itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     padding: EdgeInsets.all(10.r),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey.shade200),
                       borderRadius: BorderRadius.circular(14.r),
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         // Shimmer for Image
                         Shimmer.fromColors(
                           baseColor: Colors.grey[300]!,
                           highlightColor: Colors.grey[100]!,
                           child: Container(
                             height: 70.h,
                             width: 60.w,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: Colors.grey[300],
                             ),
                           ),
                         ),
                         SizedBox(width: 10.w),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             // Shimmer for Address
                             Shimmer.fromColors(
                               baseColor: Colors.grey[300]!,
                               highlightColor: Colors.grey[100]!,
                               child: Container(
                                 width: 150.w,
                                 height: 18.h,
                                 color: Colors.grey[300],
                               ),
                             ),
                             SizedBox(height: 10.w),
                             // Shimmer for Time Ranges
                             Shimmer.fromColors(
                               baseColor: Colors.grey[300]!,
                               highlightColor: Colors.grey[100]!,
                               child: Container(
                                 width: 100.w,
                                 height: 10.h,
                                 color: Colors.grey[300],
                               ),
                             ),
                             SizedBox(height: 10.w),
                             // Shimmer for Date
                             Shimmer.fromColors(
                               baseColor: Colors.grey[300]!,
                               highlightColor: Colors.grey[100]!,
                               child: Container(
                                 width: 120.w,
                                 height: 10.h,
                                 color: Colors.grey[300],
                               ),
                             ),
                             SizedBox(height: 10.w),
                             // Shimmer for Work Type Button
                             Shimmer.fromColors(
                               baseColor: Colors.grey[300]!,
                               highlightColor: Colors.grey[100]!,
                               child: Container(
                                 width: 90.w,
                                 height: 35.h,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(24.r),
                                   color: Colors.grey[300],
                                 ),
                               ),
                             ),
                             SizedBox(height: 10.w),
                             // Shimmer for "View Status" Button
                             Shimmer.fromColors(
                               baseColor: Colors.grey[300]!,
                               highlightColor: Colors.grey[100]!,
                               child: Container(
                                 width: 110.w,
                                 height: 35.h,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(24.r),
                                   color: Colors.grey[300],
                                 ),
                               ),
                             ),
                             SizedBox(height: 10.h),
                           ],
                         ),
                       ],
                     ),
                   ),
                 );
               }
             ),
           );

                }else if (findJobApplyController.openAppliedJobResponseModel.isEmpty){
                  return Center(child: CustomText(text: "No Data Available",));
                }else{
                  return  RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: findJobApplyController.openAppliedJobResponseModel.length+1,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if(index < findJobApplyController.openAppliedJobResponseModel.length){
                          final appliedJobs = findJobApplyController.openAppliedJobResponseModel[index];
                          return Padding(
                            padding:  EdgeInsets.all(10.r),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CustomNetworkImage(
                                    imageUrl: "${ApiConstants.imageBaseUrl}${appliedJobs.clientImage}",
                                    height: 70.h,
                                    width: 60.w,
                                    boxFit: BoxFit.cover,
                                    boxShape: BoxShape.circle,
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: appliedJobs.address,
                                        color: AppColors.buttonPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontsize: 18.sp,
                                      ),
                                      SizedBox(height: 10.w),
                                      CustomText(
                                        text: appliedJobs.timeRanges,
                                        color: AppColors.buttonPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontsize: 10.sp,
                                      ),
                                      SizedBox(height: 10.w),
                                      CustomText(
                                        text: "${TimeFormatHelper.formatDate(appliedJobs.date)}",
                                        color: AppColors.buttonPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontsize: 10.sp,
                                      ),
                                      SizedBox(height: 10.w),

                                      CustomButtonCommon(
                                        title: appliedJobs.workType,
                                        onpress: () {

                                        },
                                        fontSize: 12.sp,
                                        height: 35.h,
                                        width: 90.w,
                                        color: Color(0xFFEAF8F9),
                                        titlecolor: AppColors.buttonPrimaryColor,
                                        allBorderRadius: BorderRadius.circular(24.r,),
                                      ),
                                      SizedBox(height: 10.w),

                                      Padding(
                                        padding: EdgeInsets.only(left: 130.w),
                                        child: CustomButton(title: "View Status",
                                          titlecolor: AppColors.buttonPrimaryColor,fontSize: 14.sp,
                                          onpress: ()=> appliedJobs.status == "Application send" ? _showApplicantDialog(context) :appliedJobs.status == "You got this shift" ?  _showGotShiftDialog(context) : _showFiledDialog(context)
                                        ,width: 110.w,height: 35,bordercolor: Colors.grey,),
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }else if(index>= findJobApplyController.openAppliedJobResponseModel.length){
                          return findJobApplyController.isJob.value? CustomLoader(): SizedBox.shrink();
                        }
                        return SizedBox.shrink();


                      },
                    ),
                  );
                }

              }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFiledDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.transparent,
        child: FiledBySomeoneCard(
          icon:  AppIcons.warningIcon,
          firstText: 'Filed by someone Else',
          secondText: 'Filled by someone else',
        )
      ),
    );
  }
  void _showGotShiftDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.transparent,
        child: FiledBySomeoneCard(
          icon: AppIcons.shiftIcon,
          firstText: 'You Got this shift',
          secondText: 'The shift has been added to your schedule.Thank you!',
        )
      ),
    );
  }
  void _showApplicantDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.transparent,
        child: FiledBySomeoneCard(
          icon:  AppIcons.applicationIcon,
          firstText: 'Application sent ',
          secondText: 'Your application has been received and is being reviewed.',
        )
      ),
    );
  }

}



class FiledBySomeoneCard extends StatelessWidget {
  final String icon;

  final String firstText;
  final String secondText;

  const FiledBySomeoneCard({
    super.key,
    required this.icon,
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB39DDB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(height: 12),
          Text(
            firstText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            secondText,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
