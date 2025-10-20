
import 'package:careshiftapp/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../helpers/helpers.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class BookingTestScreen extends StatefulWidget {
  @override
  _BookingTestScreenState createState() => _BookingTestScreenState();
}

class _BookingTestScreenState extends State<BookingTestScreen> {
  List<dynamic> bookingsData = []; // This will store the API response data
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings(); // Fetch data on screen load
  }

  Future<void> fetchBookings() async {
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/shift/my-booking'), // Replace with your actual API URL
      headers: {
        'Authorization': 'Bearer $bearerToken', // Include your Bearer token here
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        bookingsData = data['data']; // Store the 'data' field from the response
        isLoading = false; // Set loading to false after data is fetched
      });
    } else {
      // Handle error if the request fails
      setState(() {
        isLoading = false;
      });
      print('Failed to load data');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(text: "Bookings",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,

      ),
      body: isLoading
          ?
      _buildShimmerEffect()// Loading state
          : SingleChildScrollView(
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
            SizedBox(height: 10.h,),
            Column(

              children: _generateBookingWidgets(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateBookingWidgets() {
    List<Widget> bookingWidgets = [];

    for (var bookingData in bookingsData) {
      String date = bookingData["date"]; // e.g. "2025-07-14"
      List<dynamic> bookingsForDate = bookingData["data"]; // e.g. list of bookings

      // Add a ColoredHeader widget for each date
      bookingWidgets.add(ColoredHeader(
        text: _formatDate(date), // Display only day, month, and year
        textAlign: TextAlign.center,
      ));

      // Add booking cards for each booking on that date
      if (bookingsForDate.isNotEmpty) {
        for (var booking in bookingsForDate) {
          bookingWidgets.add(
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.bookingDetailsScreen, arguments: {
                    'id': booking['id'],
                    'date': date,
                  }, preventDuplicates: false);
                },
                child: BookingCard(
                  imagePath: "${ApiConstants.imageBaseUrl}${booking["image"]!}",
                  title: booking["client"]!,
                  time: booking["time"]!,
                  address: booking["address"]!,
                  addressFontsize: 12.sp,
                ),
              ),
            ),
          );
        }
      } else {
        // Handle the case where there are no bookings for a specific date
        bookingWidgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Container(
              height: 100.h,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(child: CustomText(text: "No Valid Schedule")),
            ),
          ),
        );
      }

      // Add spacing between date blocks
      bookingWidgets.add(SizedBox(height: 20.h));
    }

    return bookingWidgets;
  }
  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(3, (index) {
          return Column(
            children: [
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
