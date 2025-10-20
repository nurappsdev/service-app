import 'package:careshiftapp/services/api_constants.dart';
import 'package:careshiftapp/services/client_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

class EarningController extends GetxController {

  var earningsList = <GetEarningResponseModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;

  // Fetch earnings data
  Future<void> fetchEarnings() async {
    try {
      isLoading(true); // Start loading

      // Replace with your API URL
      final response = await ApiClient.getData("/earning/monthly-history");

      if (response.statusCode == 200 || response.statusCode == 201 ) {
        // If response is successful, parse the data
        // List data = response.body;
        // earningsList.value = data
        //     .map((item) => GetEarningResponseModel.fromJson(item))
        //     .toList();
        var data = List<GetEarningResponseModel>.from(response.body["data"].map((x) => GetEarningResponseModel.fromJson(x)));
         earningsList.value = data;
      } else {
        errorMessage.value = "Failed to load data";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading(false); // End loading
    }
  }

  RxBool isEarnHistory = false.obs;
  var errorMessage2 = "".obs;
Rx<EarningHistoryResponse> earningHistoryResponse = EarningHistoryResponse().obs;
  Future<void> getEarningHistory(DateTime startDate, DateTime endDate) async {
    try {
      isEarnHistory(true);
      final response = await ApiClient.getData("/earning/daily-history?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}");
      if (response.statusCode == 200) {
        earningHistoryResponse.value = EarningHistoryResponse.fromJson(response.body['data']);
      } else {
        errorMessage2.value = "Failed to load data";
      }
    } catch (e) {
      errorMessage2.value = "Error: $e";
    } finally {
      isEarnHistory(false); // End loading
    }
  }



}
