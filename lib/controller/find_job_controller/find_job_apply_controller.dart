

import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../services/client_service.dart';

class FindJobApplyController extends GetxController{

  RxList<OpenAppliedJobResponseModel> openAppliedJobResponseModel = <OpenAppliedJobResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getJobAppliedWithModalData();
  }

  ///=================pagination----------------
  ///----------------------- home sweepstakes list-=---------------
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);


  void loadMore() {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getJobAppliedWithModalData();
      print("**********************print here");
      update();
    }
    print("**********************print here**************");
  }


  RxBool isJob = false.obs;

  Future<void> getJobAppliedWithModalData() async {
    try {
      if(page.value == 1){
        openAppliedJobResponseModel.clear();
        isJob(true);
      }
      var response = await ApiClient.getData( "/shift?type=applied&page=${page.value}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        totalPage = jsonDecode(response.body['pagination']['totalPage'].toString()) ?? 0;
        currentPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
        totalResult = jsonDecode(response.body['pagination']['total'].toString()) ?? 0;
        var data = List<OpenAppliedJobResponseModel>.from(response.body["data"].map((x) => OpenAppliedJobResponseModel.fromJson(x)));

        openAppliedJobResponseModel.addAll(data);
        update();
        isJob(false);
      } else {
        isJob(false);
        ToastMessageHelper.errorMessageShowToster(response.body["message"]);
      }
    } catch (e) {
      // ToastMessageHelper.errorMessageShowToster("Error fetching data: $e");
    } finally {
      isJob(false);
    }
  }

}