




import 'package:careshiftapp/routes/app_routes.dart';
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





class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  //final String bookingId = Get.arguments;
  //
  // String? id;
  // String? date;

  String id = Get.arguments['id'];  // Booking ID
  String date = Get.arguments['date'].toString();
  @override
  void initState() {
    super.initState();
    // Accessing Get.arguments in initState
    bookingController.getBookingDetailsData(id);

  }

  // Helper method to format the date into a readable string (e.g., "27 Jun, 2025")
  String _formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day} ${_getMonthName(parsedDate.month)}, ${parsedDate.year}";
  }

  // Helper method to get the month name (e.g., "Jan", "Feb", etc.)
  String _getMonthName(int month) {
    final List<String> monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return monthNames[month - 1];
  }

  Map<String, String> serviceIcons = {
    "Companionship": AppIcons.compIcon,
    "Domestic Assistance": AppIcons.domesIcon,
    "Driving & Community Access": AppIcons.driveIcon,
    "Showering & Bathing: Partial Assistance": AppIcons.showerIcon,
    "Yard Maintenance": AppIcons.showerIcon,
  };

  bool isCheckedIn = false;

  void _handleButtonPress() async {
    if (isCheckedIn) {
      final shouldCheckOut = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Check Out"),
            content: const Text("Do you want to check out?"),
            actions: [
              CustomButtonCommon(title: "No", onpress: ()=> Navigator.of(context).pop(false),width: 110.w,color: Colors.grey[100],titlecolor: AppColors.hitTextColor000000,),
              CustomButtonCommon(title: "Yes", onpress: (){
                Get.toNamed(AppRoutes.completedWorkScreen,preventDuplicates: false);
              },width: 110,),

            ],
          );
        },
      );

      if (shouldCheckOut == true) {
        setState(() {
          isCheckedIn = false;
        });
      //  widget.onCheckOut?.call();
      }
    } else {
      setState(() {
        isCheckedIn = true;
      });
      // widget.onCheckIn?.call();
    }
  }


  BookingController bookingController = Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
   // bookingController.getBookingDetailsData(id);
    print(id);
    print(date);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(

        title: CustomText(text: "Booking Details",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.buttonPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Obx(()=>
            bookingController.isOpenDetails.value ?
            _buildShimmerEffect():
             Container(
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
                    SizedBox(height: 20.h,),
                    ///========Check in-------------------
        
                    BookingCheckInCard(
                      imagePath: "${ApiConstants.imageBaseUrl}${bookingController.bookingDetailsResponseModel.value.details?.image}",
                      name: bookingController.bookingDetailsResponseModel.value.details?.client ?? "N/A",
                      startDate: _formatDate(date),
                      startTime: bookingController.bookingDetailsResponseModel.value.details?.startTime ?? "N/A",
                      finishDate: _formatDate(date),
                      finishTime: bookingController.bookingDetailsResponseModel.value.details?.endTime ?? "N/A",
                      // onCheckIn: (){},
                      // onCheckOut: () {
                      //   print("Checked Out");
                      // },
                    ),
                    bookingController.bookingDetailsResponseModel.value.isToday == true ?  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: bookingController.bookingDetailsResponseModel.value.checkIn == false ? SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: CustomButtonCommon(
                            loading: bookingController.isJobCheckIn.value,
                            title: "CHECK IN", onpress: (){
                              bookingController.jobCheckIn(id);
                        }),
        
                      ):SizedBox(
                        width: double.infinity,
                        height: 44.h,
                        child: ElevatedButton(
                          //onPressed: _handleButtonPress,
                           onPressed: (){
                             bookingController.bookingDetailsResponseModel.value.checkOut == false ? showDialog<bool>(
                               context: context,
                               builder: (context) {
                                 return AlertDialog(
                                   title: const Text("Check Out"),
                                   content: const Text("Do you want to check out?"),
                                   actions: [
                                     CustomButtonCommon(title: "No", onpress: ()=> Navigator.of(context).pop(false),width: 110.w,color: Colors.grey[100],titlecolor: AppColors.hitTextColor000000,),
                                     CustomButtonCommon(title: "Yes", onpress: (){
                                       Get.toNamed(AppRoutes.completedWorkScreen, arguments: {'id':id}, preventDuplicates: false);
                                     },width: 110,),
        
                                   ],
                                 );
                               },
                             ):SizedBox.shrink();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D3B66),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            bookingController.bookingDetailsResponseModel.value.checkOut == false ? "CHECK OUT": "Shift Completed" ,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ):SizedBox.shrink(),
                    ColoredHeader(
                      text: "  Rates for this job",
                      textAlign: TextAlign.start, // or TextAlign.start, TextAlign.end, etc.
                    ),
        
                    ///========Rates For this job------------------
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppIcons.timeIcon),
                              SizedBox(width: 20.w,),
                              CustomText(text: "Duration",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.buttonPrimaryColor,
                              )
        
                            ],
                          ),
                          CustomText(text: "${bookingController.bookingDetailsResponseModel.value.details?.duration.toString() ?? "N/A"} Hours",
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.buttonPrimaryColor,)
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) ,
                      child: Divider(),
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppIcons.dolarIcon),
                              SizedBox(width: 20.w,),
                              CustomText(text: "Hourly Rate",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.buttonPrimaryColor,
                              )
        
                            ],
                          ),
                          Column(
                            children: [
                              CustomText(text: "\$${bookingController.bookingDetailsResponseModel.value.details?.hourlyRate.toString() ?? "N/A"}",
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
                    SizedBox(height: 30.h,),
        
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) ,
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
                              CustomText(text: "\$ ${bookingController.bookingDetailsResponseModel.value.details?.travelRate.toString() ?? "N/A"}",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.buttonPrimaryColor,),
                              CustomText(text: "per Km",
                                fontsize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonPrimaryColor,),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
        
        
                    ///------------invoice---------------------
                    ColoredHeader(
                      text: "  Invoice Summary",
                      textAlign: TextAlign.start, // or TextAlign.start, TextAlign.end, etc.
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) ,
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
                              CustomText(text: "\$ ${bookingController.bookingDetailsResponseModel.value.details?.total.toString() ?? "N/A"}",
                                fontsize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.buttonPrimaryColor,),
                              SizedBox(height: 4.h),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffBFEAED),
                                    borderRadius: BorderRadius.circular(30.r)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 4.w),
                                  child: CustomText(text: "One off",
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
        
                    ///-----------Service--------------
                    ColoredHeader(
                      text: "  Services",
                      textAlign: TextAlign.start, // or TextAlign.start, TextAlign.end, etc.
                    ),
                    SizedBox(height: 20.h,),
                    SizedBox(
                      height:(bookingController.bookingDetailsResponseModel.value.details!.services!.length * 80.h).clamp(60.h,200.h),
                      child: ListView.builder(
                        itemCount: bookingController.bookingDetailsResponseModel.value.details?.services!.length  ?? 0,
                        itemBuilder: (context, index) {
                          String? serviceName = bookingController.bookingDetailsResponseModel.value.details?.services![index];
                          String iconPath = serviceIcons[serviceName] ?? '';
        
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(iconPath),
                                    SizedBox(width: 20.w,),
                                    CustomText(text: serviceName.toString(),
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
        
        
                    ///-----------Location--------------
                    ColoredHeader(
                      text: "  Location",
                      textAlign: TextAlign.start, // or TextAlign.start, TextAlign.end, etc.
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w) ,
                      child:  Row(
                        children: [
                          SvgPicture.asset(AppIcons.locationIcon),
                          SizedBox(width: 20.w,),
                          CustomText(text: "${bookingController.bookingDetailsResponseModel.value.details?.address.toString() ?? "N/A"}",
                            fontsize: 14.sp,
                            fontWeight: FontWeight.w700,
                            maxline: 2,
                            color: AppColors.buttonPrimaryColor,
                          )
        
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(3, (index) {
          return Column(
            children: [
              SizedBox(height: 20,),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child:  ColoredHeader(
                  text: "  Rates for this job",
                  textAlign: TextAlign.start, // or TextAlign.start, TextAlign.end, etc.
                ),
              ),
              SizedBox(height: 20.h),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20.h,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(height: 20.h),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          );
        }),
      ),
    );
  }
}



class BookingCheckInCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String startDate;
  final String startTime;
  final String finishDate;
  final String finishTime;
  // final VoidCallback? onCheckIn;
  // final VoidCallback? onCheckOut;

  const BookingCheckInCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.startDate,
    required this.startTime,
    required this.finishDate,
    required this.finishTime,
    // this.onCheckIn,
    // this.onCheckOut,
  }) : super(key: key);

  @override
  _BookingCheckInCardState createState() => _BookingCheckInCardState();
}

class _BookingCheckInCardState extends State<BookingCheckInCard> {
  bool isCheckedIn = false;
  //
  // void _handleButtonPress() async {
  //   if (isCheckedIn) {
  //     final shouldCheckOut = await showDialog<bool>(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("Check Out"),
  //           content: const Text("Do you want to check out?"),
  //           actions: [
  //             CustomButtonCommon(title: "No", onpress: ()=> Navigator.of(context).pop(false),width: 110.w,color: Colors.grey[100],titlecolor: AppColors.hitTextColor000000,),
  //             CustomButtonCommon(title: "Yes", onpress: (){
  //               Get.toNamed(AppRoutes.completedWorkScreen,preventDuplicates: false);
  //             },width: 110,),
  //
  //           ],
  //         );
  //       },
  //     );
  //
  //     if (shouldCheckOut == true) {
  //       setState(() {
  //         isCheckedIn = false;
  //       });
  //       widget.onCheckOut?.call();
  //     }
  //   } else {
  //     setState(() {
  //       isCheckedIn = true;
  //     });
  //     widget.onCheckIn?.call();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = TextStyle(
      fontSize: 12.sp,
      color: AppColors.buttonPrimaryColor,// AppColors.buttonPrimaryColor এর জায়গায় ব্যবহার করুন
      fontWeight: FontWeight.w500,
    );
    final textStyleDate = TextStyle(
      fontSize: 12.sp,
      color: Color(0xff3D6994)
    );
    final textStyleTime = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      elevation: 2,
      color: Colors.grey[50],
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: widget.imagePath,
                  height: 70.h,
                  width: 60.w,
                  boxFit: BoxFit.cover,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(width: 12.w),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.buttonPrimaryColor,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Start", style: textStyleLabel),
                    Text(widget.startDate, style: textStyleDate),
                    SizedBox(height: 4.h),
                    Text(widget.startTime, style: textStyleTime),
                  ],
                ),
                Container(
                  width: 1,
                  height: 50.h,
                  color: Colors.blue, // AppColors.primaryColor ব্যবহার করুন
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Finish", style: textStyleLabel),
                    Text(widget.finishDate, style: textStyleDate),
                    SizedBox(height: 4.h),
                    Text(widget.finishTime, style: textStyleTime),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // SizedBox(
            //   width: double.infinity,
            //   height: 44.h,
            //   child: ElevatedButton(
            //     onPressed: _handleButtonPress,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF0D3B66),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: Text(
            //       isCheckedIn ? "CHECK OUT" : "CHECK IN",
            //       style: const TextStyle(
            //         fontWeight: FontWeight.bold,
            //         letterSpacing: 1.2,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
