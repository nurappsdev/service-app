
import 'package:careshiftapp/routes/app_routes.dart';
import 'package:careshiftapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controller/controllers.dart';
import '../../widgets/widgets.dart';

class NotificationsScreenss extends StatefulWidget {
  const NotificationsScreenss({super.key});

  @override
  State<NotificationsScreenss> createState() => _NotificationsScreenssState();
}

class _NotificationsScreenssState extends State<NotificationsScreenss> {
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
    notificationController.getNotificationData(); // Make sure this loads the data
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notificationController.loadMore();
        print("load more true");
      }
    });
  }


  // Method to refresh the job applied data
  Future<void> _onRefresh() async {
    notificationController.page.value = 1;
    await notificationController.getNotificationData(); // Fetch fresh data
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  NotificationController notificationController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    notificationController.page.value;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(

        title: CustomText(text: "Notifications",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w600,fontsize: 20.sp,),backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.buttonPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx((){
        print(notificationController.notificationResponseModel);

        if(notificationController.isNotification.value){
          return  Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child:  ListView.builder(
                shrinkWrap: true,
                itemCount: 3, // Just a placeholder for shimmer items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      children: [
                        InkWell(
                          onTap:(){
                            Get.toNamed(AppRoutes.jobDetailsScreen,preventDuplicates: false);
                          },
                          child: Container(
                            decoration:
                            BoxDecoration(
                              color: Colors.lightBlue.shade100.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.notifications, color: Colors.teal, size: 28),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.buttonPrimaryColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'We have a client in [Suburb, Postcode] who needs support. Are you available to help?',
                                        style: TextStyle(fontSize: 14, color: Colors.black87),
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                        '16 Jun, 2025',
                                        style: TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        //     child: _buildSection('Today', [true, false, false])),
                        // _buildSection('Yesterday', [false, false]),
                      ],
                    ),
                  );
                }
            ),
          );
        }else if (notificationController.notificationResponseModel.isEmpty){
          return Center(child: CustomText(text: "No Data Available",));
        }else{
          return ListView.builder(
            shrinkWrap: true,
            itemCount: notificationController.notificationResponseModel.length +1,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if(index < notificationController.notificationResponseModel.length){
                final notific = notificationController.notificationResponseModel[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Get.toNamed(AppRoutes.jobDetailsScreen,preventDuplicates: false);
                        },
                        child: Container(
                          decoration:
                          BoxDecoration(
                            color: Colors.lightBlue.shade100.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.notifications, color: Colors.teal, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${notific.title ?? "N/A"}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.buttonPrimaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'We have a client in [Suburb, Postcode] who needs support. Are you available to help?',
                                      style: TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      '16 Jun, 2025',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      //     child: _buildSection('Today', [true, false, false])),
                      // _buildSection('Yesterday', [false, false]),
                    ],
                  ),
                );
              }else if(index>= notificationController.notificationResponseModel.length){
                return notificationController.isNotification.value? CustomLoader(): SizedBox.shrink();
              }
              return SizedBox.shrink();

            },
          );
        }

      }
      ),
    
    );
  }

  Widget _buildNotification({
    required bool isHighlighted,
  }) {
    return Container(
      decoration: isHighlighted
          ? BoxDecoration(
        color: Colors.lightBlue.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      )
          : null,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notifications, color: Colors.teal, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Job Listing Available!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonPrimaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'We have a client in [Suburb, Postcode] who needs support. Are you available to help?',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 6),
                const Text(
                  '16 Jun, 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<bool> highlights) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          ...highlights.map((highlight) => _buildNotification(isHighlighted: highlight)),
        ],
      ),
    );
  }
}
