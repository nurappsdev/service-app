
import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<Map<String, String>> bookings = [
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
  final List<Map<String, String>> bookingsEmpty = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(text: "Bookings",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,

      ),
      body: Container(
        width: double.infinity,
        color: AppColors.whiteColor,
        child: SingleChildScrollView(
          child: Column(
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
              SizedBox(height: 26.h,),
              ColoredHeader(
                text: "Thu, 27 Jun, 2025",
                textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.h),
                child: InkWell(
                  onTap: (){
                    Get.toNamed(AppRoutes.bookingDetailsScreen,preventDuplicates: false);
                  },
                  child: BookingCard(
                    imagePath: 'assets/images/profileImg.png',
                    title: "Burwood, 2E45",
                    time: "Thu, 09:00 am - 11:00 am",
                    address: "2 Conder Street, Burwood NSW 2134",
                    addressFontsize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              ColoredHeader(
                text: "Fri, 28 Jun, 2025",
                textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      child: BookingCard(
                        imagePath: booking["imagePath"]!,
                        title: booking["title"]!,
                        time: booking["time"]!,
                        address: booking["address"]!,
                        addressFontsize: 12.sp,
                      ),
                    );
                    },
                ),
              ),
              SizedBox(height: 20.h,),
              ColoredHeader(
                text: "Sat, 29 Jun, 2025",
                textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: bookingsEmpty.isEmpty ? Container(
                  height: 100.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(child: CustomText(text: "No Valid Schedule",),),
                ): ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookingsEmpty.length,
                  itemBuilder: (context, index) {
                    final booking = bookingsEmpty[index];
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      child:
                      BookingCard(
                        imagePath: booking["imagePath"]!,
                        title: booking["title"]!,
                        time: booking["time"]!,
                        address: booking["address"]!,
                        addressFontsize: 12.sp,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h,),
              ColoredHeader(
                text: "Sat, 29 Jun, 2025",
                textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: bookingsEmpty.isEmpty ? Container(
                  height: 100.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(child: CustomText(text: "No Valid Schedule",),),
                ): ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookingsEmpty.length,
                  itemBuilder: (context, index) {
                    final booking = bookingsEmpty[index];
                    return Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      child:
                      BookingCard(
                        imagePath: booking["imagePath"]!,
                        title: booking["title"]!,
                        time: booking["time"]!,
                        address: booking["address"]!,
                        addressFontsize: 12.sp,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
