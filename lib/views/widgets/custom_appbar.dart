
import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/controllers.dart';
import '../../services/services.dart';
import 'cachanetwork_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showUserInfo;
  final String? title;
  final String? userName;
  final String? greeting;
  final String? userImageUrl;
  final VoidCallback? onNotificationTap;
  final int? notificationCount;
  final VoidCallback? onBackTap;

  CustomAppBar({
    Key? key,
    this.title,
    this.showUserInfo = false,
    this.userName,
    this.greeting = 'Hello, Good Morning',
    this.userImageUrl,
    this.onNotificationTap,
    this.notificationCount,
    this.onBackTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: showUserInfo ? _buildUserInfo(context) : _buildTitle(context),
    );
  }
  ProfileSetupController profileSetupController = Get.put(ProfileSetupController());
  Widget _buildUserInfo(BuildContext context) {
profileSetupController.getUserData();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // User image and name (Wrap with Obx to make it reactive)
        Obx(() {
          final user = profileSetupController.getUserResponseModel.value;
          return Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.profileScreen, preventDuplicates: false);
                },
                child:  CustomNetworkImage(
                  imageUrl: "${ApiConstants.imageBaseUrl}${user.image}",
                  height: 60.h,
                  width: 50.w,
                  boxFit: BoxFit.cover,
                  boxShape: BoxShape.circle,
                ),


              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${user.firstName} ${user.lastName}" ,  // Dynamic User Name
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),

        // Notification icon with badge
        Stack(
          children: [
            IconButton(
              onPressed: onNotificationTap,
              icon: Icon(Icons.notifications, color: Colors.white, size: 30.sp),
            ),
            if ((notificationCount ?? 0) > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '${notificationCount!}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBackTap ?? () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        const SizedBox(width: 8),
        Text(
          title ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
