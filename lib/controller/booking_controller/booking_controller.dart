import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../routes/app_routes.dart';
import '../../services/client_service.dart';
import '../../services/services.dart';
import '../../utils/utils.dart';

class BookingController extends GetxController{
  //
  // @override
  // onInit(){
  //   getBookingDetailsData();
  //   super.onInit();
  // }

  RxBool isOpenDetails = false.obs;
  Rx<BookingDetailsResponseModel> bookingDetailsResponseModel = BookingDetailsResponseModel().obs;
  getBookingDetailsData(String id) async {
    isOpenDetails(true);
    try {
      var response = await ApiClient.getData(ApiConstants.getBookingDetailsEndPoint(id));
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        bookingDetailsResponseModel.value = BookingDetailsResponseModel.fromJson(response.body['data']);
      }else if(response.statusCode == 404){
        ToastMessageHelper.errorMessageShowToster(response.body["message"] ?? "not found ");
      } else {
        ToastMessageHelper.errorMessageShowToster(response.body["message"] ?? "Unexpected error");
      }
    } catch (e, stacktrace) {
      print("Exception: $e");
      print("Stacktrace: $stacktrace");
      // ToastMessageHelper.errorMessageShowToster("An error occurred: $e");
    } finally {
      isOpenDetails(false);
    }
  }


  ///======================isJobCheckIn+++++++++++++++++++
  RxBool  isJobCheckIn = false.obs;
  Future<void>  jobCheckIn(String userApplyId) async{
    isJobCheckIn(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body ={


    };
    var response = await ApiClient.postData("/shift/today-checkin/$userApplyId",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
     update();
      ToastMessageHelper.successMessageShowToster(response.body['message'].toString());

      isJobCheckIn(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      isJobCheckIn(false);
    }
  }



  ///======================isJobCheckIn+++++++++++++++++++
  RxBool  isJobCheckOut = false.obs;
  Future<void> jobCheckOut(
      String? userApplyId,
      String? what_tasks_did_you_complete_during_this_shift,
      String? have_you_noticed_any_changes_in_the_clients_condition_behavior_or_needs,
      String? did_any_incident_occur_during_this_shift,
      String? did_you_travel_with_the_client_during_this_shift,
      String? how_many_kilometers_did_you_travel_with_the_client_only,
      ) async{
    isJobCheckOut(true);
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var body ={
          "what_tasks_did_you_complete_during_this_shift": what_tasks_did_you_complete_during_this_shift,
          "have_you_noticed_any_changes_in_the_clients_condition_behavior_or_needs": have_you_noticed_any_changes_in_the_clients_condition_behavior_or_needs,
          "did_any_incident_occur_during_this_shift": did_any_incident_occur_during_this_shift,
          "did_you_travel_with_the_client_during_this_shift": did_you_travel_with_the_client_during_this_shift,
          "how_many_kilometers_did_you_travel_with_the_client_only": how_many_kilometers_did_you_travel_with_the_client_only,
    };
    var response = await ApiClient.postData("/shift/today-checkout/$userApplyId",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      getBookingDetailsData(userApplyId!);
      update();
      ToastMessageHelper.successMessageShowToster(response.body['message'].toString());

      isJobCheckOut(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      isJobCheckOut(false);
    }
  }




}