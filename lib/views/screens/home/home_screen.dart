import 'package:careshiftapp/controller/controllers.dart';
import 'package:careshiftapp/routes/app_routes.dart';
import 'package:careshiftapp/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/helpers.dart';
import '../../../services/services.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> bookingData = [
    {
      "imagePath": 'assets/images/profileImg.png',
      "title": "Burwood, 2E45",
      "time": "Thu, 09:00 am - 11:00 am",
      "address": "2 Conder Street, Burwood NSW 2134",
    },
    {
      "imagePath": 'assets/images/profileImg.png',
      "title": "Parramatta, 5A12",
      "time": "Fri, 01:00 pm - 03:00 pm",
      "address": "10 Church Street, Parramatta NSW 2150",
    },
    // Add more data maps here...
  ];

  FindJobController findJobController = Get.put(FindJobController());

   HomeBookingController homeBookingController = Get.put(HomeBookingController());

   ProfileSetupController profileSetupController = Get.find<ProfileSetupController>();

  @override
  Widget build(BuildContext context) {
    findJobController.getJobAppliedData();
    homeBookingController.getHomeBookingData();

    return Scaffold(
      appBar: CustomAppBar(
        showUserInfo: true,
        notificationCount: 0,
        onNotificationTap: (){
          Get.toNamed(AppRoutes.notificationScreen,preventDuplicates: false);
          },
      ),
      body:  SafeArea(
        child: Container(
          color: AppColors.primaryColor,
          child:
              Container(
                height: Get.height,
              width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(24.r),topRight: Radius.circular(24.r), ),
                          color: AppColors.whiteColor),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h,),
                            CustomText(text: "Today’s Bookings",fontWeight: FontWeight.w600,color: Color(0xff1B666C),),
                            SizedBox(height: 14.h),
                            Obx(() {
                              // Check if the data is loading
                              if (homeBookingController.isBookingHome.value) {
                                // Show loading indicator while data is being fetched
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child:
                                  Container(
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

                                            // Shimmer for "View Status" Button
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                );
                              }else if(homeBookingController.getHomeBookingResponseModel.isEmpty){
                               return Center(child: CustomText(text: "No Booking available",));
                              } else {
                                // Show the CarouselSlider once the data is available
                                return CarouselSlider(
                                  options: CarouselOptions(
                                    height: 116.h,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                  ),
                                  items: homeBookingController.getHomeBookingResponseModel
                                      .map((booking) {  // Use 'booking' here instead of 'item'
                                    return InkWell(
                                      onTap: () {
                                        // Navigate to the booking details screen
                                        Get.toNamed(
                                            AppRoutes.bookingDetailsScreen,
                                            arguments: {
                                              'id': booking.id,
                                              "date": booking.date
                                            },
                                            preventDuplicates: false);
                                      },
                                      child: BookingCard(
                                        imagePath: "${ApiConstants.imageBaseUrl}${booking.image}", // Assuming 'clientImage' holds the image URL
                                        title: booking.address ?? "N/A",  // 'address' field from the model
                                        time: booking.time ?? "N/A",  // 'timeRanges' field from the model
                                        address: booking.address ?? "N/A",  // 'address' from the model (if needed)
                                        addressFontsize: 8.5.sp,  // Font size for the address
                                      ),
                                    );
                                  }).toList(), // Convert the map to a list of widgets
                                );
                              }
                            }),

                            SizedBox(height: 14.h),
                            // BookingCard(
                            //   imagePath: 'assets/images/profileImg.png',
                            //   title: "Burwood, 2E45",
                            //   time: "Thu, 09:00 am - 11:00 am",
                            //   address: "2 Conder Street, Burwood NSW 2134",
                            // ),
                            SizedBox(height: 40.h),


                            CustomText(text: "Recommended Jobs",fontWeight: FontWeight.w600,color: Color(0xff1B666C),),
                            SizedBox(height: 14.h),

                            Obx(() {
                              // Check if the data is loading
                              if (findJobController.isJob.value) {
                                // Show CustomLoader while the data is being fetched
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child:
                                  Container(
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
                              } else if(findJobController.openAppliedJobResponseModel.isEmpty){
                                return Center(child: CustomText(text: "No Recommended Job",));
                              } else {
                                // Show the CarouselSlider once the data is available
                                return CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 0.9,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                  ),
                                  items: findJobController.openAppliedJobResponseModel
                                      .take(5)  // Take only the first 5 items
                                      .map((booking) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigate to job details screen and pass booking ID as argument
                                        Get.toNamed(AppRoutes.jobDetailsScreen, preventDuplicates: false, arguments: booking.id);
                                      },
                                      child: bookingCardItem(
                                        imagePath: "${ApiConstants.imageBaseUrl}${booking.clientImage}",  // Assuming you have the image URL
                                        title: booking.address, // Title from the model
                                        time: booking.timeRanges,  // Time from the model
                                        date: "${TimeFormatHelper.formatDate(booking.date)} - ${booking.workType}",  // Date and Work type
                                        button1Title: booking.frequency,  // Frequency from the model
                                        button2Title: 'Waiting for your response',  // Static text
                                      ),
                                    );
                                  }).toList(),  // Convert the map to a list of widgets
                                );
                              }
                            }),

                            SizedBox(height: 40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.earningScreen,preventDuplicates: false);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10.r),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(14.r)),
                                  child:  SvgPicture.asset("assets/icons/earningIcons.svg"),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(6.r),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(14.r)),
                                child:  SvgPicture.asset("assets/icons/incidentIcon.svg"),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.contactUssScreen,preventDuplicates: false);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10.r),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(14.r)),
                                  child:  SvgPicture.asset("assets/icons/contactIcon.svg"),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                    ),

              ),

        ),
      ),
    );
  }
}

