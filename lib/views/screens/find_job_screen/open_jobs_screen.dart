
import 'package:careshiftapp/routes/app_routes.dart';
import 'package:careshiftapp/services/api_constants.dart';
import 'package:careshiftapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class OpenJobsScreen extends StatefulWidget {
  const OpenJobsScreen({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<OpenJobsScreen> createState() => _OpenJobsScreenState();
}

class _OpenJobsScreenState extends State<OpenJobsScreen> {
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
      _addScrollListener();
  }

  @override
  void didChangeDependencies() {
    // Refresh data when returning to this screen
    super.didChangeDependencies();
    findJobController.getJobAppliedData(); // Make sure this loads the data
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        findJobController.loadMore();
        print("load more true");
      }
    });
  }


  // Method to refresh the job applied data
  Future<void> _onRefresh() async {
    findJobController.page.value = 1; // Reset to page 1 when refreshing
    await findJobController.getJobAppliedData(); // Fetch fresh data
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  FindJobController findJobController = Get.put(FindJobController());
  @override
  Widget build(BuildContext context) {
    findJobController.page.value;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: Obx((){
               if(findJobController.isJob.value){
                 return  Shimmer.fromColors(
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
               }else if (findJobController.openAppliedJobResponseModel.isEmpty){
              return Center(child: CustomText(text: "No Data Available",));
              }else{
                return  RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                     itemCount: findJobController.openAppliedJobResponseModel.length +1,
                    controller: _scrollController,
                     itemBuilder: (context, index) {
                       if(index < findJobController.openAppliedJobResponseModel.length){
                         final booking = findJobController.openAppliedJobResponseModel[index];
                         return Padding(
                           padding:  EdgeInsets.all(10.r),
                           child: InkWell(
                             onTap: (){
                               Get.toNamed(AppRoutes.jobDetailsScreen,preventDuplicates: false,arguments: booking.id);
                             },
                             child: bookingCardItem(
                               imagePath: "${ApiConstants.imageBaseUrl}${booking.clientImage}",
                               title: "${booking.address}",
                               time: booking.timeRanges,
                               date: "${TimeFormatHelper.formatDate(booking.date)} - ${booking.workType}",
                               button1Title: booking.frequency,
                               button2Title: 'Waiting for your response',
                             ),
                           ),
                         );
                       }else if(index>= findJobController.openAppliedJobResponseModel.length){
                        return findJobController.isJob.value? CustomLoader(): SizedBox.shrink();
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
}
