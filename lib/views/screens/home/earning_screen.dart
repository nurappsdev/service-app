

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:careshiftapp/utils/app_colors.dart';
import 'package:careshiftapp/utils/app_icons.dart';
import 'package:careshiftapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/Earning_controller/earning_controller.dart';
import '../../widgets/widgets.dart';

// class EarningScreen extends StatefulWidget {
//   const EarningScreen({super.key});
//
//   @override
//   State<EarningScreen> createState() => _EarningScreenState();
// }
//
// class _EarningScreenState extends State<EarningScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//
//         title: CustomText(text: "Earnings",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: AppColors.buttonPrimaryColor),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         color: AppColors.whiteColor,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 2, // Thickness of the divider
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300, // Divider color
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.15), // Shadow color
//                       blurRadius: 2,
//                       offset: Offset(0, 2), // Shadow position
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 26.h,),
//               ColoredHeader(
//                 text: "Jun, 2025",
//                 textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
//               ),
//               SizedBox(height: 26.h,),
//               InkWell(
//                 onTap: (){
//                   Get.toNamed(AppRoutes.earningDetailsScreen,preventDuplicates: false);
//                 },
//                 child: PaymentCard(
//                   dateRange: '1 Jun - 15 Jun',
//                   amount: 400,
//                   isPaid: false,
//                 ),
//               ),
//               PaymentCard(
//
//                 dateRange: '16 Jun - 30 Jun',
//                 amount: 400,
//                 isPaid: true,
//               ),
//               SizedBox(height: 26.h,),
//
//
//
//               ColoredHeader(
//                 text: "May, 2025",
//                 textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
//               ),
//               SizedBox(height: 26.h,),
//               PaymentCard(
//                 dateRange: '1 May - 15 May',
//                 amount: 400,
//                 isPaid: true,
//               ),
//               PaymentCard(
//                 dateRange: '16 Jun - 30 Jun',
//                 amount: 400,
//                 isPaid: true,
//               ),
//               SizedBox(height: 26.h,),
//
//
//               ColoredHeader(
//                 text: "Apr, 2025",
//                 textAlign: TextAlign.center, // or TextAlign.start, TextAlign.end, etc.
//               ),
//               SizedBox(height: 26.h,),
//               PaymentCard(
//                 dateRange: '1 Apr - 15 Apr',
//                 amount: 400,
//                 isPaid: true,
//                 isPaidUnpaidButton: false,
//               ),
//               PaymentCard(
//                 dateRange: '16 Apr - 30 Apr',
//                 amount: 400,
//                 isPaid: true,
//                 isPaidUnpaidButton: false,
//               ),
//               SizedBox(height: 26.h,)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  final EarningController _controller = Get.put(EarningController());

  @override
  void initState() {
    super.initState();
    // Fetch earnings data when the screen is initialized
    _controller.fetchEarnings();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: "Earnings",
          color: AppColors.buttonPrimaryColor,
          fontWeight: FontWeight.w600,
          fontsize: 20.sp,
        ),
        backgroundColor: AppColors.whiteColor,
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
          child: Obx(() {
            // Checking the loading state
            if (_controller.isLoading.value) {
              return Center(child: CustomLoader());
            }
        
            // If there's an error
            if (_controller.earningsList.isEmpty) {
              return Center(child: Text("No Data Available"));
            }
        
            // If data is loaded successfully, display the earnings list
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 2, // Divider thickness
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300, // Divider color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26.h),
                  ..._controller.earningsList.map((earning) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColoredHeader(
                          text: earning.header ?? "",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 26.h),
                        ...earning.periods!.map((period) {
                          return InkWell(
                            onTap: () {
                              DateTime startDate = period.startDate!; // Assuming startDate is a DateTime object
                              DateTime endDate = period.endDate!; // Example end date
        
                              // Convert DateTime to ISO8601 string format
                              String startDateStr = startDate.toIso8601String();
                              String endDateStr = endDate.toIso8601String();
        
                              Get.toNamed(
                                AppRoutes.earningDetailsScreen,
                                preventDuplicates: false,
                                arguments: {"startDate": startDateStr, "endDate": endDateStr},
                              );
                            },
                            child: PaymentCard(
                              dateRange: period.label ?? "",
                              amount: period.amount?.toDouble() ?? 0.0,
                              isPaid: period.status == "Paid",
                            ),
                          );
                        }).toList(),
                        SizedBox(height: 26.h),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
        
          }),
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String dateRange;
  final double amount;
  final bool isPaid;
  final bool? isPaidUnpaidButton;
  final String? iconPath;
  const PaymentCard({
    super.key,
    required this.dateRange,
    required this.amount,
    required this.isPaid,
     this.isPaidUnpaidButton = true,
   this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 2.r,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          // Icon container
          SvgPicture.asset(
            iconPath ?? AppIcons.dolarIcon, // use passed icon or default
          ),
          SizedBox(width: 12.w),
          // Date range text
          Expanded(
            child: Text(
              dateRange,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.buttonPrimaryColor,
              ),
            ),
          ),
          // Amount and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.buttonPrimaryColor,
                ),
              ),
              SizedBox(height: 4.h),
              isPaidUnpaidButton == true ?  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isPaid ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  isPaid ? 'Paid' : 'Unpaid',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isPaid ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                ),
              ) : SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
