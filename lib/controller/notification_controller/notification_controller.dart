import 'dart:convert';

import 'package:careshiftapp/utils/app_constant.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../services/client_service.dart';
import '../../services/services.dart';


class NotificationController extends GetxController {

  RxList<NotificationsResponseModel> notificationResponseModel = <NotificationsResponseModel>[].obs;

  ///=================pagination----------------
  ///----------------------- home sweepstakes list-=---------------
  RxInt page = 1.obs;
  var totalPage = 0;
  var currentPage = 0;
  var totalResult = 0;

  RxBool isNotification = false.obs;

  void loadMore() {
    print("==========================================total page $totalPage page No: ${page.value} == total result $totalResult");
    if (totalPage > page.value) {
      page.value += 1;
      getNotificationData();  // Fetch next page data
      print("********************** Data loaded");
    }
    print("********************** Load more ended");
  }

  Future<void> getNotificationData() async {
    try {
      if (page.value == 1) {
        notificationResponseModel.clear(); // Clear existing notifications when fetching first page
        isNotification(true);  // Show loading spinner
      }

      var response = await ApiClient.getData("/notification?page=${page.value}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var paginationData = response.body['data']['pagination'];

        totalPage = paginationData['totalPage'] ?? 0;
        currentPage = paginationData['currentPage'] ?? 0;
        totalResult = paginationData['totalData'] ?? 0;

        var notificationsData = response.body['data']['notifications'];
        var data = List<NotificationsResponseModel>.from(notificationsData.map((x) => NotificationsResponseModel.fromJson(x)));

        print("Fetched Data: $data");
        notificationResponseModel.addAll(data);  // Add fetched data to the list

        isNotification(false);  // Hide loading spinner
      } else {
        isNotification(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"] ?? "Something went wrong");
      }
    } catch (e) {
      isNotification(false);
      print("Error fetching data: $e");
      ToastMessageHelper.errorMessageShowToster("Error fetching data: $e");
    } finally {
      // Ensure loading spinner is stopped
      isNotification(false);
    }
  }






  ///****************************************************************************///

  //
  // void listenNotification() async {
  //   String tokens = await PrefsHelper.getString(AppConstants.bearerToken);
  //   try {
  //     SocketServices.socket.on("notifications", (data) {
  //       print("=========> Response Message: $data -------------------------");
  //       if (data != null) {
  //      //   GetNotificationResponseModel demoData = GetNotificationResponseModel.fromJson(data);
  //         // print("---------------demoData: ${demoData.senderId} \n ${demoData.runtimeType}");
  //        // getNotificationResponseModel.insert(0, demoData);
  //         increaseNotificationCount();
  //         update();
  //         print('Message added to chatMessages list');
  //       } else {
  //         print("No message data found in the response");
  //       }
  //     });
  //   } catch (e, s) {
  //     print("Error: $e");
  //     print("Stack Trace: $s");
  //   }
  // }


  RxBool unReadLoading = false.obs;
  RxInt unreadCount = 0.obs;
  unReadCount()async{
    unReadLoading(true);
    var response = await ApiClient.getData("/notification/count");
    if(response.statusCode == 200){
      unreadCount.value = response.body["data"]["count"];
      update();
      unReadLoading(false);
    }else{
      unReadLoading(false);
    }
  }




  void increaseNotificationCount() {
    int count = unreadCount.value;
    unreadCount.value = (count + 1);
    update();
  }

  //
  // Future<void> makeNotificationSeen() async {
  //   final url = Uri.parse('${ApiConstants.baseUrl}/notification/notification-make-seen'); // Replace with your actual URL
  //   String bearerToken = await  PrefsHelper.getString("AppConstants.bearerToken");
  //   final headers = {
  //     'Authorization': 'Bearer $bearerToken', // Use the token here
  //     'Content-Type': 'application/json', // Content type for sending JSON data
  //   };
  //
  //   // Create an empty request body, as it is shown in the screenshot
  //   final body = jsonEncode({
  //
  //   });
  //
  //   try {
  //     final response = await http.put(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = jsonDecode(response.body);
  //       print('Response: ${data['message']}');
  //       // Handle successful response
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       // Handle error response
  //     }
  //   } catch (e) {
  //     print('Request failed: $e');
  //     // Handle exceptions
  //   }
  // }
}
