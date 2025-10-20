import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class EarningDetailsScreen extends StatefulWidget {
  const EarningDetailsScreen({super.key});

  @override
  State<EarningDetailsScreen> createState() => _EarningDetailsScreenState();
}

final List<Map<String, String>> transactions = [
  {'date': '28 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
  {'date': '27 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
  {'date': '26 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
  {'date': '25 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
  {'date': '24 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
  {'date': '23 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
  {'date': '22 Feb, 25', 'name': 'Henry Arthur', 'amount': '\$400'},
];
class _EarningDetailsScreenState extends State<EarningDetailsScreen> {

  late DateTime startDate;
  late DateTime endDate;
  final EarningController _controller = Get.put(EarningController());
  @override
  void initState() {
    super.initState();

    // Retrieve the arguments passed from the previous screen
    final arguments = Get.arguments;

    // Parse the arguments as DateTime objects
    startDate = DateTime.parse(arguments['startDate']);
    endDate = DateTime.parse(arguments['endDate']);
    _controller.getEarningHistory(startDate, endDate);
  }
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Widget build(BuildContext context) {
    print("startdate$startDate");
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(text: "Earning Details",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.buttonPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        color: AppColors.whiteColor,
        child: SingleChildScrollView(
          child: Obx(() {
            if (_controller.isEarnHistory.value) {
              return Center(child: CustomLoader());
            }
            // If there's an error
            if (_controller.errorMessage2.isNotEmpty) {
              return Center(child: Text(_controller.errorMessage2.value));
            }

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
                SizedBox(height: 26.h,),
                Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        width: double.infinity, // specify width
                        height: 180.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(AppImages.earnImg,),
                              fit: BoxFit.cover),),
                        child: Column(
                          children: [
                            SizedBox(height: 50.h,),
                            CustomText(text: "Amount",
                              fontsize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: "\$${_controller.earningHistoryResponse
                                  .value.total ?? "N/A"}",
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontsize: 32.sp,)
                          ],
                        ),
                      ),
                    ),
                SizedBox(height: 10.h,),
                Divider(),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Date",
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,),
                      CustomText(text: "Amount",
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,)
                    ],
                  ),
                ),
                ..._controller.earningHistoryResponse.value.history!.map((
                    period) {
                  return Container(
                    width: double.infinity,
                    color: AppColors.whiteColor,
                    child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    // Date + Name
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          period.date != null
                                              ? DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(period.date!
                                                  .toIso8601String()))
                                              : "N/A", // handle null date
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: Color(0xff093056),
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          period.client ?? "N/A",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Color(0xff5C82A5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Amount
                                    Text(
                                      period.amount.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: Color(0xff093056),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1, color: Colors.grey.shade300),
                            ],
                          ),
                        )
                    ),
                  );
                }).toList(),

                // Obx(() {
                //   // Checking if the data is loading
                //   if (_controller.isEarnHistory.value) {
                //     return Center(child: CustomLoader()); // Show a loading indicator while data is loading
                //   }
                //
                //   // Checking for any error in fetching data
                //   if (_controller.errorMessage2.isNotEmpty) {
                //     return Center(child: Text(_controller.errorMessage2.value)); // Show an error message if there is an error
                //   }
                //
                //   // Proceed if the data is successfully loaded
                //   return ListView.builder(
                //     itemCount: _controller.earningHistoryResponse.value.history?.length ?? 0,
                //     itemBuilder: (context, index) {
                //       final period = _controller.earningHistoryResponse.value.history![index];
                //
                //       return Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                //         child: Column(
                //           children: [
                //             Padding(
                //               padding: EdgeInsets.symmetric(vertical: 12.h),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   // Date + Name
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         period.date != null
                //                             ? DateFormat('yyyy-MM-dd').format(DateTime.parse(period.date!.toIso8601String()))
                //                             : "N/A", // handle null date
                //                         style: TextStyle(
                //                           fontWeight: FontWeight.w600,
                //                           fontSize: 14.sp,
                //                           color: Color(0xff093056),
                //                         ),
                //                       ),
                //                       SizedBox(height: 4.h),
                //                       Text(
                //                         period.client ?? "N/A",
                //                         style: TextStyle(
                //                           fontSize: 12.sp,
                //                           color: Color(0xff5C82A5),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   // Amount
                //                   Text(
                //                     period.amount.toString(),
                //                     style: TextStyle(
                //                       fontWeight: FontWeight.w600,
                //                       fontSize: 14.sp,
                //                       color: Color(0xff093056),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             Divider(height: 1, color: Colors.grey.shade300),
                //           ],
                //         ),
                //       );
                //     },
                //   );
                // }),

              ],
            );
          }
          ),
        ),
      ),
    );
  }
}
